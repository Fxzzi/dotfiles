#!/usr/bin/env sh

echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference

sleep 1
pkill -SIGUSR2 waybar
