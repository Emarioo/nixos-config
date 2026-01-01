#!/usr/bin/env bash

# exec-once = swww-daemon &

if [ "$1" == "img" ]; then
    swww-daemon & swww img $NIX2_CONFIG/wallpapers/shorekeeper-flowers-wallhaven.png
else
    LD_LIBRARY_PATH=/run/opengl-driver/lib \
        __NV_PRIME_RENDER_OFFLOAD=1 \
        __GLX_VENDOR_LIBRARY_NAME=nvidia \
        mpvpaper -s -o "
            hwdec=nvdec
            gpu-api=vulkan
            gpu-context=wayland
            scale=bilinear
            interpolation=no
            no-audio
            loop" ALL $NIX2_CONFIG/wallpapers/shorekeeper-rainy-day-wuthering-waves-moewalls-com.mp4
fi
