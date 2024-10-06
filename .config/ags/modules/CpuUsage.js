const cpuUsage = Variable("", {
  poll: [
    2000,
    `bash -c "grep 'cpu ' /proc/stat | awk '{usage = ($2 + $4) * 100 / ($2 + $4 + $5); print usage}'"`,
    (out) => `${parseFloat(out).toFixed(0)}%`,
  ],
});

export function CpuUsageWidget() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "activity-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "cpu-usage",
        label: cpuUsage.bind(),
      }),
    ],
  });
}
