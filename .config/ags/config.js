import App from "resource:///com/github/Aylur/ags/app.js";
import Gdk from "gi://Gdk";

// import widget modules
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

// Add svg icons from the ./icons directory
App.addIcons(`${App.configDir}/icons/`);

function Left(monitorName) {
  return Widget.Box({
    spacing: 10,
    children: [
      Workspaces(monitorName), // Pass the monitor name to Workspaces
      TimeWidget(),
      DateWidget(),
      BatteryWidget(),
    ],
  });
}

function Center() {
  return Widget.Box({
    spacing: 10,
    children: [ClientTitleWidget()],
  });
}

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

function Bar(gdkMonitor) {
  const monitorName = getMonitorName(gdkMonitor); // Get the monitor name
  return Widget.Window({
    name: `bar-${monitorName}`, // Use the monitor name for the window name
    class_name: "bar",
    gdkmonitor: gdkMonitor, // Pass the Gdk.Monitor object directly
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(monitorName), // Pass the monitor name to Left
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

const hyprland = await Service.import("hyprland");
const display = Gdk.Display.get_default();

// Returns monitor name (e.g. DP-3, HDMI-A-1, etc) from Gdk.Monitor object
function getMonitorName(gdkmonitor) {
  const screen = display.get_default_screen();
  for (let i = 0; i < display.get_n_monitors(); ++i) {
    if (gdkmonitor === display.get_monitor(i))
      return screen.get_monitor_plug_name(i);
  }
  return null;
}

// Returns a Gdk.Monitor object from the name of the monitor.
function getMonitorByName(name) {
  for (let i = 0; i < display.get_n_monitors(); ++i) {
    const gdkMonitor = display.get_monitor(i); // Get the GdkMonitor
    const gdkMonitorName = getMonitorName(gdkMonitor); // Get the monitor name using getMonitorName
    if (gdkMonitorName === name) {
      return gdkMonitor; // Return the Gdk.Monitor if the name matches
    }
  }
  return null; // Return null if no match found
}

// Loops through all ags windows and removes them.
function removeAllWindows() {
  const windows = App.windows; // Get all windows from the App
  windows.forEach((window) => {
    App.removeWindow(window); // Remove each window
  });
}

// Initialises a bar for each monitor.
function InitBars() {
  removeAllWindows(); // first remove all existing windows
  hyprland.monitors.map((mon) => {
    const monitorName = mon.name; // get the name from the Hyprland JSON
    const gdkMonitor = getMonitorByName(monitorName); // get the corresponding Gdk.Monitor
    if (gdkMonitor) {
      App.addWindow(Bar(gdkMonitor, mon.id)); // Pass both Gdk.Monitor and hyprland monitor id into Bar()
    }
  });
}

// listen for monitor connects and disconnects, and reinit all bars.
hyprland.connect("event", (_, name) => {
  if (name === "monitoradded" || name === "monitorremoved") {
    console.log(`monitor change event detected!`);
    InitBars();
  }
});

// App configuration
App.config({
  style: "./style.css",
});

// Reload CSS when wallust updates colors
Utils.subprocess(
  ["inotifywait", "--event", "modify", "-m", "-q", `${App.configDir}`],
  () => {
    console.log("Caught wallust reload, reloading CSS!");
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
  },
);

// on startup, create bars for all monitors
InitBars();
