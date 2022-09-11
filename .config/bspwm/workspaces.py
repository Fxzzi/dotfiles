#!/usr/bin/env python
import os


names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
monitors = os.popen("bspc query -M --names", mode="r").read().split("\n")
monitors.pop()

desktops = {}
for x in monitors:
    desktops[x] = []

for i, x in enumerate(names):
    #desktops[monitors[i % len(monitors)]].append(x)
    desktops[monitors[(i + 1) % len(monitors)]].append(x)

for key in desktops.keys():
    os.system(f"bspc monitor {key} -d {' '.join(desktops[key])}")
