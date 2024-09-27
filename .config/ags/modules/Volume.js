const audio = await Service.import("audio");

export function VolumeWidget() {
  const icons = {
    70: "audio-volume-high-symbolic",
    40: "audio-volume-medium-symbolic",
    1: "audio-volume-low-symbolic",
    0: "audio-volume-muted-symbolic",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [70, 40, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100,
        );
    return icons[icon];
  }

  return Widget.Box({
    children: [
      Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
        class_name: "icon",
      }),
      Widget.Label({
        hexpand: true,
        label: audio.speaker
          .bind("volume")
          .as((v) => `${Math.round(v * 100)}%`),
        class_name: "bar-button-label volume",
      }),
    ],
  });
}
