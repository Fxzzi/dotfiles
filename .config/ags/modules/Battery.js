const battery = await Service.import("battery");

export function BatteryWidget() {
  const icons = {
    100: {
      charging: "battery-100-charging-symbolic",
      charged: "battery-full-charged-symbolic",
      default: "battery-100-symbolic",
    },
    90: {
      charging: "battery-090-charging-symbolic",
      default: "battery-090-symbolic",
    },
    80: {
      charging: "battery-080-charging-symbolic",
      default: "battery-080-symbolic",
    },
    70: {
      charging: "battery-070-charging-symbolic",
      default: "battery-070-symbolic",
    },
    60: {
      charging: "battery-060-charging-symbolic",
      default: "battery-060-symbolic",
    },
    50: {
      charging: "battery-050-charging-symbolic",
      default: "battery-050-symbolic",
    },
    40: {
      charging: "battery-040-charging-symbolic",
      default: "battery-040-symbolic",
    },
    30: {
      charging: "battery-030-charging-symbolic",
      default: "battery-030-symbolic",
    },
    20: {
      charging: "battery-020-charging-symbolic",
      default: "battery-020-symbolic",
    },
    10: {
      charging: "battery-010-charging-symbolic",
      default: "battery-010-symbolic",
    },
    5: {
      charging: "battery-empty-charging-symbolic",
      default: "battery-empty-symbolic",
    },
    placeholder: "battery-missing-symbolic", // Placeholder icon
  };

  function getIcon() {
    // Handle the case when battery.percent is invalid
    if (battery.percent < 0 || battery.percent > 100) {
      return icons.placeholder; // Return placeholder icon
    }

    const level = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 5].find(
      (threshold) => battery.percent >= threshold,
    );

    const iconSet = icons[level];

    if (battery.charged) {
      return iconSet.charged || iconSet.default;
    }

    if (battery.charging) {
      return iconSet.charging || iconSet.default;
    }

    return iconSet.default || icons.placeholder; // Fallback to placeholder if no default
  }

  function getClassName() {
    if (battery.charged) return "icon charged";
    if (battery.charging) return "icon charging";
    return "icon";
  }

  return Widget.Box({
		visible: battery.bind("available").as((a) => a),
    children: [
      Widget.Icon({
        icon: Utils.watch(getIcon(), battery, getIcon),
        class_name: Utils.watch(getClassName(), battery, getClassName),
        //size: 20,
      }),
      Widget.Label({
                class_name: "battery",
        label: battery
          .bind("percent")
          .as((p) => (p > 0 ? `${Math.round(p)}%` : "0%")),
      }),
    ],
  });
}
