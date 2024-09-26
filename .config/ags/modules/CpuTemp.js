const GLib = imports.gi.GLib;

const cpuTemp = Variable("", {
  poll: [
    5000,
    () => {
      try {
        // Read hardware temperature
        const [hwmonSuccess, hwmonTempBytes] = GLib.file_get_contents(
          "/sys/class/hwmon/hwmon6/temp1_input",
        );
        const hwmonTemp = hwmonSuccess
          ? parseFloat(new TextDecoder("utf-8").decode(hwmonTempBytes)) / 1000
          : null; // Convert mC to C

        return hwmonTemp ? `${hwmonTemp.toFixed(0)}°C` : "N/A";
      } catch (error) {
        console.error("Error reading CPU temperature:", error);
        return "N/A";
      }
    },
  ],
});

export function CpuTempWidget() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "thermometer-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "temperature-usage",
        label: cpuTemp.bind(),
      }),
    ],
  });
}
