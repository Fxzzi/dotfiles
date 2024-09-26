const hyprland = await Service.import("hyprland");

export function ClientTitleWidget() {
  const maxLength = 96;
  return Widget.Box({
    children: [
      Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client
          .bind("title")
          .as((title) =>
            title.length > maxLength
              ? `${title.substring(0, maxLength - 3)}...`
              : title,
          ),
      }),
    ],
  });
}
