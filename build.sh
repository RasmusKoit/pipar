#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE="zmkfirmware/zmk-build-arm:stable"
BUILD_DIR="$REPO_DIR/.build"
WIN_OUT="/mnt/c/Users/raks4/Downloads/pipar-firmware"

usage() {
    echo "Usage: $0 <target>"
    echo ""
    echo "Targets:"
    echo "  left          Build left half (peripheral)"
    echo "  right         Build right half (central) with trackpoint"
    echo "  reset         Build left half settings_reset"
    echo "  dev           Build pipar_dev bring-up board"
    echo "  all           Build all targets (including dev)"
    echo "  clean         Remove build artifacts"
    echo "  export        Copy firmware files to Windows Downloads"
    echo "  shell         Open a shell in the build container"
    echo ""
    echo "Firmware output: .build/<target>/zephyr/zmk.uf2"
    exit 1
}

# Run the container as the host user so files created by west/git/cmake
# (FETCH_HEAD, refs, build output) are owned by you, not root. -e HOME=/tmp
# gives the (passwd-less) UID a writable home for `git config --global`.
DOCKER_COMMON="docker run --rm --user $(id -u):$(id -g) -e HOME=/tmp -v $REPO_DIR:/workspace -w /workspace $IMAGE bash -c"
INIT_CMD="git config --global --add safe.directory '*'"

do_west_init() {
    local init=""
    if [ ! -f "$REPO_DIR/.west/config" ]; then
        init="cd /workspace/config && west init -l . && cd /workspace && "
    fi
    echo "==> Updating west modules..."
    $DOCKER_COMMON "$INIT_CMD && ${init}west update"
}

build_target() {
    local board="$1"
    local build_name="$2"
    local extra_args="${3:-}"

    echo "==> Building $build_name ($board)..."
    $DOCKER_COMMON "$INIT_CMD && west zephyr-export && \
        west build -s zmk/app -d .build/$build_name -b $board \
            -- -DZMK_CONFIG=/workspace/config $extra_args \
        && echo '==> SUCCESS: .build/$build_name/zephyr/zmk.uf2'"
}

[ $# -eq 0 ] && usage

case "$1" in
    left)
        do_west_init
        build_target "pipar_point@left" "left"
        ;;
    right)
        do_west_init
        build_target "pipar_point@right" "right" \
            '-DSNIPPET="trackpoint;studio-rpc-usb-uart"'
        ;;
    reset)
        do_west_init
        build_target "pipar_point@left" "reset" \
            "-DSHIELD=settings_reset"
        ;;
    dev)
        do_west_init
        build_target "pipar_dev" "dev"
        ;;
    all)
        do_west_init
        build_target "pipar_point@left" "left"
        build_target "pipar_point@right" "right" \
            '-DSNIPPET="trackpoint;studio-rpc-usb-uart"'
        build_target "pipar_point@left" "reset" \
            "-DSHIELD=settings_reset"
        build_target "pipar_dev" "dev"
        "$0" export
        ;;
    clean)
        echo "==> Cleaning build artifacts..."
        docker run --rm -v "$REPO_DIR:/workspace" -w /workspace "$IMAGE" rm -rf .build
        echo "==> Done."
        ;;
    export)
        mkdir -p "$WIN_OUT"
        copied=0
        for target in left right reset; do
            if [ -f "$BUILD_DIR/$target/zephyr/zmk.uf2" ]; then
                cp "$BUILD_DIR/$target/zephyr/zmk.uf2" "$WIN_OUT/pipar_point_${target}.uf2"
                echo "==> Copied pipar_point_${target}.uf2"
                copied=$((copied + 1))
            fi
        done
        if [ -f "$BUILD_DIR/dev/zephyr/zmk.uf2" ]; then
            cp "$BUILD_DIR/dev/zephyr/zmk.uf2" "$WIN_OUT/pipar_dev.uf2"
            echo "==> Copied pipar_dev.uf2"
            copied=$((copied + 1))
        fi
        if [ "$copied" -eq 0 ]; then
            echo "No firmware files found. Run './build.sh all' first."
            exit 1
        fi
        echo "==> $copied firmware file(s) exported to: C:\\Users\\raks4\\Downloads\\pipar-firmware\\"
        ;;
    shell)
        do_west_init
        docker run --rm -it \
            --user $(id -u):$(id -g) -e HOME=/tmp \
            -v "$REPO_DIR:/workspace" \
            -w /workspace \
            "$IMAGE" \
            bash -c "$INIT_CMD && west zephyr-export && bash"
        ;;
    *)
        usage
        ;;
esac
