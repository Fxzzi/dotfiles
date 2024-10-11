const hyprland = await Service.import("hyprland");

// Accepts the monitor name instead of the ID
export function Workspaces(monitorName) {
  const activeId = hyprland.active.workspace.bind("id");

  // Dynamically filter workspaces by monitor name on each update
  const workspaces = hyprland.bind("workspaces").as((ws) => {
    const filteredWorkspaces = ws
      .filter(({ monitor }) => monitor === monitorName)
      .sort((a, b) => a.id - b.id); // Ensure workspaces are sorted by ID

    // Create buttons for each workspace
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
