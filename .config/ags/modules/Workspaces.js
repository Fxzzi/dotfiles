const hyprland = await Service.import("hyprland");

// Accepts the monitor name instead of the ID
export function Workspaces(monitorName) {
  const activeId = hyprland.active.workspace.bind("id");

  const workspaces = hyprland.bind("workspaces").as((ws) => {
    // Filter workspaces by the monitor name and sort them
    const filteredWorkspaces = ws
      .filter(({ monitor }) => monitor === monitorName) // Compare monitor names
      .sort((a, b) => a.id - b.id);

    // Create buttons for each workspace
    return filteredWorkspaces.map(({ id }) =>
      Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: activeId.as((active) => (active === id ? "focused" : "")),
      }),
    );
  });

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}
