const GLib = imports.gi.GLib;

const memUsage = Variable("", {
  poll: [
    2000,
    () => {
      try {
        const [success, meminfoBytes] = GLib.file_get_contents("/proc/meminfo");
        if (!success || !meminfoBytes)
          throw new Error("Failed to read /proc/meminfo");

        const meminfo = new TextDecoder("utf-8").decode(meminfoBytes);
        const totalMatch = meminfo.match(/MemTotal:\s+(\d+)/);
        const availableMatch = meminfo.match(/MemAvailable:\s+(\d+)/);

        if (!totalMatch || !availableMatch)
          throw new Error("Failed to parse /proc/meminfo");

        const totalRamInBytes = parseInt(totalMatch[1], 10) * 1024;
        const availableRamInBytes = parseInt(availableMatch[1], 10) * 1024;
        const usedRamInGiB =
          (totalRamInBytes - availableRamInBytes) / (1024 * 1024 * 1024);

        return `${usedRamInGiB.toFixed(2)}GiB`;
      } catch (error) {
        console.error("Error calculating RAM usage:", error);
        return "N/A";
      }
    },
  ],
});

export function MemUsageWidget() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "pie-chart-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "memory-usage",
        label: memUsage.bind(),
      }),
    ],
  });
}
