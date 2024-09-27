import App from "resource:///com/github/Aylur/ags/app.js";
import Gdk from "gi://Gdk";
import { idle } from "resource:///com/github/Aylur/ags/utils/timeout.js";

// Import widget modules
import { DateWidget } from "./modules/Date.js";
import { TimeWidget } from "./modules/Time.js";
import { BatteryWidget } from "./modules/Battery.js";
import { VolumeWidget } from "./modules/Volume.js";
import { Workspaces } from "./modules/Workspaces.js";
import { ClientTitleWidget } from "./modules/ClientTitle.js";
import { CpuUsageWidget } from "./modules/CpuUsage.js";
import { CpuTempWidget } from "./modules/CpuTemp.js";
import { MemUsageWidget } from "./modules/MemUsage.js";
import { GpuTempWidget } from "./modules/GpuTemp.js";
import { SysTrayWidget } from "./modules/SysTray.js";

// Define per-monitor windows (bars, popups, etc.)
const perMonitorWindows = [Bar];

/* Define unique windows (no need to be created per monitor) */
const uniqueWindows = [];

// Left section of the bar
function Left(monitor) {
  return Widget.Box({
    spacing: 10,
    children: [
      Workspaces(monitor),
      TimeWidget(),
      DateWidget(),
      BatteryWidget(),
    ],
  });
}

// Center section of the bar
function Center() {
  return Widget.Box({
    spacing: 10,
    children: [ClientTitleWidget()],
  });
}

// Right section of the bar
function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 10,
    children: [
      SysTrayWidget(),
      GpuTempWidget(),
      CpuTempWidget(),
      CpuUsageWidget(),
      MemUsageWidget(),
      VolumeWidget(),
    ],
  });
}

// Bar layout for a specific monitor
function Bar(monitor) {
  return Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    gdkmonitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(monitor),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

// Run idle to set up initial windows and monitor events
idle(async () => {
  // Add unique windows (widgets that don't depend on specific monitors)
  uniqueWindows.map((win) => App.addWindow(win));

  // Get the default display and create bars for each monitor
  const display = Gdk.Display.get_default();
  if (display) {
    for (let m = 0; m < display.get_n_monitors(); m++) {
      const monitor = display.get_monitor(m);
      perMonitorWindows.map((win) => App.addWindow(win(monitor)));
    }

    // Monitor added event
    display.connect("monitor-added", (disp, monitor) => {
      perMonitorWindows.map((win) => App.addWindow(win(monitor)));
    });

    // Monitor removed event
    display.connect("monitor-removed", (disp, monitor) => {
      App.windows.forEach((window) => {
        if (window.gdkmonitor === monitor) App.removeWindow(window);
      });
    });
  }
});

// App configuration
App.config({
  style: "./style.css",
});

// Add SVG icons from the icons directory
App.addIcons(`${App.configDir}/icons/`);

// Reload CSS when wallust updates colors
Utils.subprocess(
  ["inotifywait", "--event", "modify", "-m", "-q", `${App.configDir}`],
  () => {
    console.log("Caught wallust reload, reloading CSS!");
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
  },
);
