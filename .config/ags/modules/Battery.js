const battery = await Service.import("battery");

export function BatteryWidget() {
  const icons = {
    100: { charging: "battery-100-charging-symbolic", charged: "battery-full-charged-symbolic", default: "battery-100-symbolic" },
    90: { charging: "battery-090-charging-symbolic", default: "battery-090-symbolic" },
    80: { charging: "battery-080-charging-symbolic", default: "battery-080-symbolic" },
    70: { charging: "battery-070-charging-symbolic", default: "battery-070-symbolic" },
    60: { charging: "battery-060-charging-symbolic", default: "battery-060-symbolic" },
    50: { charging: "battery-050-charging-symbolic", default: "battery-050-symbolic" },
    40: { charging: "battery-040-charging-symbolic", default: "battery-040-symbolic" },
    30: { charging: "battery-030-charging-symbolic", default: "battery-030-symbolic" },
    20: { charging: "battery-020-charging-symbolic", default: "battery-020-symbolic" },
    10: { charging: "battery-010-charging-symbolic", default: "battery-010-symbolic" },
    5: { charging: "battery-empty-charging-symbolic", default: "battery-empty-symbolic" },
    placeholder: "battery-missing-symbolic",
  };

  const formatTimeRemaining = (seconds) => {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    return `${hours}h ${minutes}m`;
  };

  const formatEnergyRate = (rate) => {
    if (rate > 0) {
      return `Discharging at ${rate.toFixed(2)} W`;
    }
    if (rate < 0) {
      return `Charging at ${Math.abs(rate).toFixed(2)} W`;
    }
    return "No energy drain or charge";
  };

  const getIcon = () => {
    if (battery.percent < 0 || battery.percent > 100) return icons.placeholder;
    const level = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 5].find(threshold => battery.percent >= threshold);
    return battery.charged ? icons[level]?.charged : battery.charging ? icons[level]?.charging : icons[level]?.default || icons.placeholder;
  };

  const getClassName = () => battery.charged ? "icon charged" : battery.charging ? "icon charging" : "icon";

  const getTooltip = () => {
    const timeRemaining = formatTimeRemaining(battery["time-remaining"]);
    const energyRate = formatEnergyRate(battery["energy-rate"]);
    if (battery.charged) return `Battery fully charged\n${energyRate}`;
    if (battery.charging) return `Charging - ${timeRemaining} left\n${energyRate}`;
    return `Battery - ${timeRemaining} remaining\n${energyRate}`;
  };

  return Widget.Box({
    visible: battery.bind("available").as(Boolean),
    tooltip_text: battery.bind("time-remaining", "energy-rate").as(() => getTooltip()),  // Bound to both time-remaining and energy-rate
    children: [
      Widget.Icon({
        icon: Utils.watch(getIcon(), battery, getIcon),
        class_name: Utils.watch(getClassName(), battery, getClassName),
      }),
      Widget.Label({
        class_name: "battery",
        label: battery.bind("percent").as(p => `${Math.max(0, Math.round(p))}%`),
      }),
    ],
  });
}
