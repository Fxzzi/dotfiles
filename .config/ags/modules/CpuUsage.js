const cpuUsage = Variable("", {
  poll: [
    2000,
    `bash -c "top -b -n 1 | grep 'Cpu(s)' | awk '{print $2}'"`,
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
