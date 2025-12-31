#!/usr/bin/env bash

# exec-once = swww-daemon &

if [ "$1" == "img" ]; then
    swww-daemon & swww img ~/wallpapers/wallhaven-mlqy18_1920x1080.png
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
            loop" ALL ~/wallpapers/shorekeeper-rainy-day-wuthering-waves-moewalls-com.mp4
fi
