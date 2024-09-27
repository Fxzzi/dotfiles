import App from "resource:///com/github/Aylur/ags/app.js";
import Gdk from "gi://Gdk";

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

App.config({
  style: "./style.css",
});

// add svg icons from icons directory
App.addIcons(`${App.configDir}/icons/`);

// reload css when wallust updates colors
Utils.subprocess(
  ["inotifywait", "--event", "modify", "-m", "-q", `${App.configDir}`],
  () => {
    console.log("Caught wallust reload, reloading css!");
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
  },
);

const range = (length, start = 1) =>
  Array.from({ length }, (_, i) => i + start);

// get number of monitors and create a bar for each
function forMonitorsAsync(widget) {
  const display = Gdk.Display.get_default();
  const n = display ? display.get_n_monitors() : 1; // Number of monitors
  return range(n, 0).forEach((monitor) => {
    widget(monitor);
  });
}

forMonitorsAsync(Bar);
