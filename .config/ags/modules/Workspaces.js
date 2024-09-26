const hyprland = await Service.import("hyprland");

export function Workspaces(monitor) {
  const activeId = hyprland.active.workspace.bind("id");

  const workspaces = hyprland.bind("workspaces").as((ws) => {
    // Filter, sort, and map to buttons
    const filteredWorkspaces = ws
      .filter(({ monitorID }) => monitorID === monitor)
      .sort((a, b) => a.id - b.id);

    return filteredWorkspaces.map(({ id }) =>
      Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: activeId.as((active) => (active === id ? "focused" : "")),
      })
    );
  });

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}
