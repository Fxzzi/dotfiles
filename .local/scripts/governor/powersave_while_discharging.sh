#!/usr/bin/env sh

echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo "balance_power" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference

sleep 1
pkill -SIGUSR2 waybar
