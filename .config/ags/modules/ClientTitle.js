const hyprland = await Service.import("hyprland");

const MAX_TITLE_LENGTH = 64;

export function ClientTitleWidget() {
  return Widget.Box({
    children: [
      Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client
          .bind("title")
          .as((title) =>
            title.length > MAX_TITLE_LENGTH
              ? `${title.substring(0, MAX_TITLE_LENGTH - 3)}...`
              : title,
          ),
      }),
    ],
  });
}
