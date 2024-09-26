const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const systemtray = await Service.import("systemtray");
const battery = await Service.import("battery");

const GLib = imports.gi.GLib;
import App from "resource:///com/github/Aylur/ags/app.js";
import Utils from "resource:///com/github/Aylur/ags/utils.js";
import Gdk from "gi://Gdk";

App.addIcons(`${App.configDir}/icons/`);

// Reload CSS when changes detected
Utils.subprocess(
  ["inotifywait", "--event", "modify", "-m", "-q", `${App.configDir}`],
  () => {
    console.log("Caught wallust reload, reloading css!");
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
  },
);

const date = Variable("", {
  poll: [360000, 'date "+%a %d/%m"'],
});

const time = Variable("", {
  poll: [1000, 'date "+%H:%M:%S"'],
});

const cpuUsage = Variable("", {
  poll: [
    2000,
    `bash -c "top -b -n 1 | grep 'Cpu(s)' | awk '{print $2}'"`,
    (out) => `${parseFloat(out).toFixed(0)}%`,
  ],
});

const memUsage = Variable("", {
  poll: [
    2000,
    () => {
      try {
        const [success, meminfoBytes] = GLib.file_get_contents("/proc/meminfo");
        if (!success || !meminfoBytes)
          throw new Error("Failed to read /proc/meminfo");

        const meminfo = new TextDecoder("utf-8").decode(meminfoBytes);
        const totalMatch = meminfo.match(/MemTotal:\s+(\d+)/);
        const availableMatch = meminfo.match(/MemAvailable:\s+(\d+)/);

        if (!totalMatch || !availableMatch)
          throw new Error("Failed to parse /proc/meminfo");

        const totalRamInBytes = parseInt(totalMatch[1], 10) * 1024;
        const availableRamInBytes = parseInt(availableMatch[1], 10) * 1024;
        const usedRamInGiB =
          (totalRamInBytes - availableRamInBytes) / (1024 * 1024 * 1024);

        return `${usedRamInGiB.toFixed(2)}GiB`;
      } catch (error) {
        console.error("Error calculating RAM usage:", error);
        return "N/A";
      }
    },
  ],
});

// Workspaces widget
function Workspaces(monitor) {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .filter(({ monitorID }) => monitorID === monitor)
      .sort((a, b) => a.id - b.id) // Sort workspaces by ID
      .map(({ id }) =>
        Widget.Button({
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${id}`),
          class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
        }),
      ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

// Client Title widget
function ClientTitle() {
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

// Time widget
function Time() {
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

// Date widget
function Date() {
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

// Memory Usage widget
function MemoryUsage() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "pie-chart-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "memory-usage",
        label: memUsage.bind(),
      }),
    ],
  });
}

function CpuUsage() {
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

// CPU Temperature widget
function CpuTemp() {
  const cpuTemp = Variable("", {
    poll: [
      5000,
      () => {
        try {
          // Read hardware temperature
          const [hwmonSuccess, hwmonTempBytes] = GLib.file_get_contents(
            "/sys/class/hwmon/hwmon6/temp1_input",
          );
          const hwmonTemp = hwmonSuccess
            ? parseFloat(new TextDecoder("utf-8").decode(hwmonTempBytes)) / 1000
            : null; // Convert mC to C

          return hwmonTemp ? `${hwmonTemp.toFixed(0)}°C` : "N/A";
        } catch (error) {
          console.error("Error reading CPU temperature:", error);
          return "N/A";
        }
      },
    ],
  });

  return Widget.Box({
    children: [
      Widget.Icon({
        icon: "thermometer-outline-symbolic",
        class_name: "icon",
        size: 20,
      }),
      Widget.Label({
        class_name: "temperature-usage",
        label: cpuTemp.bind(),
      }),
    ],
  });
}

// System Tray widget
function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({
          icon: item.bind("icon"),
          class_name: "trayicon",
          size: 20,
        }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    children: items,
    class_name: "tray",
  });
}

// Volume widget
function Volume() {
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

function Battery() {
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
    children: [
      Widget.Icon({
        icon: Utils.watch(getIcon(), battery, getIcon),
        class_name: Utils.watch(getClassName(), battery, getClassName),
        //size: 20,
      }),
      Widget.Label({
        visible: battery.bind("available").as((a) => a),
        class_name: "battery",
        label: battery
          .bind("percent")
          .as((p) => (p > 0 ? `${Math.round(p)}%` : "0%")),
      }),
    ],
  });
}

// Left section of the bar
function Left(monitor) {
  return Widget.Box({
    spacing: 10,
    children: [Workspaces(monitor), Time(), Date(), Battery()],
  });
}

// Center section of the bar
function Center() {
  return Widget.Box({
    spacing: 10,
    children: [ClientTitle()],
  });
}

// Right section of the bar
function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 10,
    children: [SysTray(), CpuTemp(), CpuUsage(), MemoryUsage(), Volume()],
  });
}

// Bar layout
function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(monitor),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

// App config
App.config({
  style: "./style.css",
});

const range = (length, start = 1) =>
  Array.from({ length }, (_, i) => i + start);

function forMonitorsAsync(widget) {
  const display = Gdk.Display.get_default();
  const n = display ? display.get_n_monitors() : 1; // Number of monitors
  return range(n, 0).forEach((monitor) => {
    widget(monitor);
  });
}

forMonitorsAsync(Bar);

export {};
