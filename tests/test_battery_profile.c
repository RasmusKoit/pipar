/*
 * Host-side unit test for the YDL375678 battery profile.
 *
 * Includes the exact header the firmware compiles and validates it
 * against reference points regenerated from the battery profiler's
 * characterization data (expected_ocv.h, emitted by gen_ocv_table.py).
 *
 * Run via: ./build.sh test  (or tests/run_tests.sh)
 */

#include <stdio.h>

#include "battery_profile_ydl375678.h"
#include "expected_ocv.h"

static int failures = 0;

#define CHECK(cond, ...)                                                                           \
    do {                                                                                           \
        if (!(cond)) {                                                                             \
            failures++;                                                                            \
            printf("FAIL: " __VA_ARGS__);                                                          \
            printf("\n");                                                                          \
        }                                                                                          \
    } while (0)

int main(void) {
    // Table shape: one entry per percent, strictly monotonic voltages
    CHECK(BATTERY_OCV_TABLE_SIZE == 101, "table has %zu entries, expected 101",
          BATTERY_OCV_TABLE_SIZE);
    for (size_t i = 0; i + 1 < BATTERY_OCV_TABLE_SIZE; i++) {
        CHECK(battery_ocv_table[i] < battery_ocv_table[i + 1],
              "table not strictly monotonic at index %zu (%u >= %u)", i, battery_ocv_table[i],
              battery_ocv_table[i + 1]);
    }

    // Clamps
    CHECK(battery_profile_mv_to_pct(0) == 0, "0mV should clamp to 0%%");
    CHECK(battery_profile_mv_to_pct(2500) == 0, "2500mV should clamp to 0%%");
    CHECK(battery_profile_mv_to_pct(4200) == 100, "4200mV should clamp to 100%%");
    CHECK(battery_profile_mv_to_pct(5000) == 100, "5000mV should clamp to 100%%");

    // The firmware table must match the profiler data it claims to encode
    int n_expected = sizeof(expected_ocv) / sizeof(expected_ocv[0]);
    CHECK(n_expected == (int)BATTERY_OCV_TABLE_SIZE, "reference has %d points, table has %zu",
          n_expected, BATTERY_OCV_TABLE_SIZE);
    for (int i = 0; i < n_expected && i < (int)BATTERY_OCV_TABLE_SIZE; i++) {
        CHECK(battery_ocv_table[expected_ocv[i].pct] == expected_ocv[i].mv,
              "table[%d] = %u mV but profiler data says %d mV — regenerate the header "
              "with gen_ocv_table.py",
              expected_ocv[i].pct, battery_ocv_table[expected_ocv[i].pct], expected_ocv[i].mv);
    }

    // Round-trip: feeding the voltage for X%% back in must return X (+/-1 for
    // rounding at bracket edges)
    for (int i = 0; i < n_expected; i++) {
        int pct = battery_profile_mv_to_pct((int16_t)expected_ocv[i].mv);
        int want = expected_ocv[i].pct;
        int diff = pct > want ? pct - want : want - pct;
        CHECK(diff <= 1, "round-trip %d mV -> %d%%, expected %d%%", expected_ocv[i].mv, pct, want);
    }

    // Physically meaningful spot checks from the characterization
    CHECK(battery_profile_mv_to_pct(3717) == 20, "3717mV (real 20%%) -> %d",
          battery_profile_mv_to_pct(3717));
    CHECK(battery_profile_mv_to_pct(3795) == 50, "3795mV (real 50%%) -> %d",
          battery_profile_mv_to_pct(3795));
    // Regression guard against the old linear table: 3717mV must never
    // again read as ~60%
    CHECK(battery_profile_mv_to_pct(3717) < 30, "3717mV reads optimistically high");

    // Monotonicity of the function itself across the full input range
    int prev = -1;
    for (int mv = 2500; mv <= 4300; mv++) {
        int pct = battery_profile_mv_to_pct((int16_t)mv);
        CHECK(pct >= prev, "mv_to_pct not monotonic at %d mV (%d < %d)", mv, pct, prev);
        CHECK(pct >= 0 && pct <= 100, "mv_to_pct out of range at %d mV: %d", mv, pct);
        prev = pct;
    }

    if (failures == 0) {
        printf("battery profile: all checks passed (%zu table entries, %d reference points)\n",
               BATTERY_OCV_TABLE_SIZE, n_expected);
        return 0;
    }
    printf("battery profile: %d check(s) FAILED\n", failures);
    return 1;
}
