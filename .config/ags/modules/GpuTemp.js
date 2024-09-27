const GLib = imports.gi.GLib;

export function GpuTempWidget() {
  const gpuTemp = Variable("", {
    poll: [
      5000,
      () => {
        try {
          // Read NVIDIA temperature
          const [nvidiaSuccess, nvidiaTempBytes] =
            GLib.file_get_contents("/tmp/nvidia-temp");
          const nvidiaTemp = nvidiaSuccess
            ? parseFloat(new TextDecoder("utf-8").decode(nvidiaTempBytes)) /
              1000
            : null;

          return nvidiaTemp ? `${nvidiaTemp.toFixed(0)}°C` : "N/A";
        } catch (error) {
          console.error("Error reading GPU temperature:", error);
          return "N/A";
        }
      },
    ],
  });

  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "expansion-card-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "temperature-usage",
        label: gpuTemp.bind(),
      }),
    ],
  });
}

