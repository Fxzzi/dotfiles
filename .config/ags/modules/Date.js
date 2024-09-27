const date = Variable("", {
  poll: [360000, 'date "+%a %d/%m"'],
});

export function DateWidget() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "calendar-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "date",
        label: date.bind(),
      }),
    ],
  });
}
