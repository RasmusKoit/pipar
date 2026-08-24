#!/bin/bash
# Post-build firmware validation: asserts the stability-critical Kconfig
# symbols actually landed in the resolved build configs, and that firmware
# artifacts exist. Run after ./build.sh left/right; ./build.sh test runs it
# automatically when builds are present.
set -u

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$REPO_DIR/.build"
failures=0

fail() {
    echo "FAIL: $1"
    failures=$((failures + 1))
}

require() { # target symbol=value
    local cfg="$BUILD_DIR/$1/zephyr/.config"
    if ! grep -qx "CONFIG_$2" "$cfg"; then
        fail "$1: CONFIG_$2 missing from resolved .config"
    fi
}

checked=0
for target in left right; do
    cfg="$BUILD_DIR/$target/zephyr/.config"
    uf2="$BUILD_DIR/$target/zephyr/zmk.uf2"

    if [ ! -f "$cfg" ]; then
        echo "SKIP: $target not built ($cfg missing)"
        continue
    fi
    checked=$((checked + 1))

    [ -s "$uf2" ] || fail "$target: firmware artifact $uf2 missing or empty"

    # Watchdog: HW fallback window must be wide enough to survive an NVS
    # page erase (~90ms CPU stall on nRF52840)
    require $target "TASK_WDT=y"
    require $target "TASK_WDT_HW_FALLBACK=y"
    require $target "TASK_WDT_MIN_TIMEOUT=1000"
    require $target "TASK_WDT_HW_FALLBACK_DELAY=1000"
    require $target "SOC_FLASH_NRF_PARTIAL_ERASE=y"
    require $target "PIPAR_WATCHDOG_FEEDER=y"

    # Battery pipeline runs on the lowprio workqueue; stock 768B overflows
    require $target "ZMK_LOW_PRIORITY_THREAD_STACK_SIZE=2048"
    require $target "HW_STACK_PROTECTION=y"

    # Battery reporting mode + profile
    require $target "ZMK_BATTERY_REPORTING_FETCH_MODE_NPM1300_DIRECT=y"
    require $target "ZMK_BATTERY_PROFILE_YDL375678=y"

    # Stuck I2C must error out, not block forever
    require $target "I2C_NRFX_TRANSFER_TIMEOUT=500"
done

if [ -f "$BUILD_DIR/right/zephyr/.config" ]; then
    # Trackpoint PS/2-over-UART needs the interrupt-driven UART API
    require right "UART_INTERRUPT_DRIVEN=y"
    require right "ZMK_SPLIT_ROLE_CENTRAL=y"
    # Central fetches peripheral battery and reports min of both halves
    require right "ZMK_SPLIT_BLE_CENTRAL_BATTERY_LEVEL_FETCHING=y"
fi

if [ "$checked" -eq 0 ]; then
    echo "firmware config: nothing to check (no builds in .build/) — run ./build.sh all first"
    exit 0
fi

if [ "$failures" -eq 0 ]; then
    echo "firmware config: all checks passed ($checked build(s))"
    exit 0
fi
echo "firmware config: $failures check(s) FAILED"
exit 1
