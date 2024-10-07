import App from "resource:///com/github/Aylur/ags/app.js";
import Gdk from "gi://Gdk";
import Gio from "gi://Gio";

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
//import { NotificationPopups } from "./modules/notificationPopups.js"

// Add svg icons from the ./icons directory
App.addIcons(`${App.configDir}/icons/`);

const createBox = (spacing, children, hpack = null) =>
  Widget.Box({ spacing, children, hpack });

const Left = (monitorName) =>
  createBox(10, [
    Workspaces(monitorName),
    TimeWidget(),
    DateWidget(),
    BatteryWidget(),
  ]);

const Center = () => createBox(10, [ClientTitleWidget()]);

const Right = () =>
  createBox(
    10,
    [
      SysTrayWidget(),
      GpuTempWidget(),
      CpuTempWidget(),
      CpuUsageWidget(),
      MemUsageWidget(),
      VolumeWidget(),
    ],
    "end",
  );

const Bar = (gdkMonitor) => {
  const monitorName = getMonitorName(gdkMonitor);
  return Widget.Window({
    name: `bar-${monitorName}`,
    class_name: "bar",
    gdkmonitor: gdkMonitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(monitorName),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
};

const hyprland = await Service.import("hyprland");
const display = Gdk.Display.get_default();

const getMonitorName = (gdkmonitor) => {
  const screen = display.get_default_screen();
  for (let i = 0; i < display.get_n_monitors(); ++i) {
    if (gdkmonitor === display.get_monitor(i))
      return screen.get_monitor_plug_name(i);
  }
  return null;
};

const getMonitorByName = (name) => {
  for (let i = 0; i < display.get_n_monitors(); ++i) {
    const gdkMonitor = display.get_monitor(i);
    if (getMonitorName(gdkMonitor) === name) return gdkMonitor;
  }
  return null;
};

const removeAllWindows = () => App.windows.forEach(App.removeWindow);

const InitBars = (wdg) => {
  
  hyprland.monitors.forEach((mon) => {
    const gdkMonitor = getMonitorByName(mon.name);
    if (gdkMonitor) App.addWindow(wdg(gdkMonitor));
  });
};

// listen for monitor connects and disconnects, and reinit all bars.
hyprland.connect("event", (_, name) => {
  if (name === "monitoradded" || name === "monitorremoved") {
    console.log(`monitor change event detected!`);
    removeAllWindows();
		InitBars(Bar);
		//InitBars(NotificationPopups)
  }
});

// App configuration
App.config({
  style: "./style.css",
});

// Reload CSS when wallust updates colors
function monitorCssFile() {
  const cssFilePath = `${App.configDir}/colors_ags.css`;

  const monitor = Utils.monitorFile(cssFilePath, (file, event) => {
    if (event === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
      console.log("Caught wallust reload, reloading CSS!");
      App.resetCss();
      App.applyCss(`${App.configDir}/style.css`);
    }
  });

  if (!monitor) {
    console.error("Failed to monitor CSS file.");
  }
}

// on startup, create bars for all monitors
InitBars(Bar);
//InitBars(NotificationPopups)
// start monitoring colors_ags.css
monitorCssFile();
