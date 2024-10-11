const battery = await Service.import("battery");

export function BatteryWidget() {
  const formatTimeRemaining = (seconds) => `${Math.floor(seconds / 3600)}h ${Math.floor((seconds % 3600) / 60)}m`;

  const formatEnergyRate = (rate) => 
    rate > 0 ? `Discharging: ${rate.toFixed(2)} W` 
    : rate < 0 ? `Charging: ${Math.abs(rate).toFixed(2)} W`
    : "Calculating...";

  const getTooltip = () => {
    const timeRemaining = formatTimeRemaining(battery["time-remaining"]);
    const energyRate = formatEnergyRate(battery["energy-rate"]);
    return battery.charged
      ? `Battery fully charged\n${energyRate}`
      : battery.charging
      ? `Charging - ${timeRemaining} left\n${energyRate}`
      : `Battery - ${timeRemaining} remaining\n${energyRate}`;
  };

  return Widget.Box({
    visible: battery.bind("available").as(Boolean),
    tooltip_text: battery.bind("time-remaining", "energy-rate").as(getTooltip),
    children: [
      Widget.Icon({
        icon: battery.bind("icon-name").as(name => name || "battery-missing-symbolic"),
        class_name: battery.bind("charged", "charging").as(() => battery.charged ? "icon charged" : battery.charging ? "icon charging" : "icon"),
      }),
      Widget.Label({
        class_name: "battery",
        label: battery.bind("percent").as(p => `${Math.max(0, Math.round(p))}%`),
      }),
    ],
  });
}
