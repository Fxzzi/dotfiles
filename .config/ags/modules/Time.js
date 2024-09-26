const time = Variable("", {
  poll: [1000, () => {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, "0");
    const minutes = String(now.getMinutes()).padStart(2, "0");
    const seconds = String(now.getSeconds()).padStart(2, "0");
    return `${hours}:${minutes}:${seconds}`;
  }],
});

export function TimeWidget() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "clock-analog-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "time",
        label: time.bind(),
      }),
    ],
  });
}
