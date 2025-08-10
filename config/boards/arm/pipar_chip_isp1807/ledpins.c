#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/init.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/sys/sys_io.h>
#include <zephyr/devicetree.h>

static int enable_leds_init(void) {

#if CONFIG_BOARD_PIPAR_CHIP_ISP1807
    const struct device *p1 = DEVICE_DT_GET(DT_NODELABEL(gpio1));
    gpio_pin_configure(p1, 0, GPIO_OUTPUT);
    gpio_pin_set(p1, 0, 1);
    gpio_pin_configure(p1, 3, GPIO_OUTPUT);
    gpio_pin_set(p1, 3, 1);
    gpio_pin_configure(p1, 12, GPIO_OUTPUT);
    gpio_pin_set(p1, 12, 1);
#endif
    return 0;
}

SYS_INIT(enable_leds_init, APPLICATION, CONFIG_APPLICATION_INIT_PRIORITY);