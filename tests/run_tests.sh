#!/bin/bash
# Firmware test harness: host-side unit tests + post-build config checks.
set -u

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TESTS_DIR="$REPO_DIR/tests"
OUT_DIR="$TESTS_DIR/.out"
rc=0

mkdir -p "$OUT_DIR"

echo "==> Battery profile unit test"
python3 "$TESTS_DIR/gen_ocv_table.py" --expected "$OUT_DIR/expected_ocv.h" || exit 1
cc -Wall -Wextra -Werror -O2 \
    -I "$REPO_DIR/zmk/app/src" -I "$OUT_DIR" \
    "$TESTS_DIR/test_battery_profile.c" -o "$OUT_DIR/test_battery_profile" || exit 1
"$OUT_DIR/test_battery_profile" || rc=1

echo "==> Firmware config validation"
bash "$TESTS_DIR/check_firmware_config.sh" || rc=1

if [ "$rc" -eq 0 ]; then
    echo "==> ALL TESTS PASSED"
else
    echo "==> TESTS FAILED"
fi
exit $rc
