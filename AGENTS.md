# AGENTS.md - Glassbar

## Project Overview

**Glassbar** is a Quickshell configuration — a Qt Quick-based Wayland status bar for Linux desktops. It targets Hyprland and uses a glassmorphic UI style. There is **no build step**; Quickshell reads the QML files directly.

## Directory Structure

```
main.qml              # Entry point — creates ShellRoot with TopBar
bars/                 # Bar layouts (TopBar.qml)
components/           # Reusable UI widgets (GlassPanel, Pill, Divider, TrayItem, CalendarView)
modules/              # Feature modules (Workspaces, Clock, Battery, Network, Media, SystemTray, IconApp)
services/             # Background daemons (CavaService for audio viz, MediaService for MPRIS)
theme/                # Theming system (Colors, Style, Metrics, Appearance, Typography, ThemeLoader)
```

## Architecture

- **Entry point**: `main.qml` — imports `bars/TopBar.qml` and renders it inside a `ShellRoot`
- **Bar layout**: `bars/TopBar.qml` uses a `PanelWindow` (Wayland layershell, top layer) with three zones: left (IconApp, Workspaces), center (Media), right (SystemTray, Network, Battery, Clock)
- **Theme hierarchy**: `ThemeLoader` (singleton) reads `~/.config/quickshell/glassbar/colors.json` at runtime → `Colors.qml` exposes the scheme → `Style.qml` aggregates colors, metrics, and glass appearance → components reference `Style.*`
- **Services** are `pragma Singleton` QML objects that run in the background and expose reactive properties to modules

## Key Commands

- **Run/preview**: `quickshell` (run from this directory or point to `main.qml`)
- **Reload**: Quickshell auto-reloads on file save — no manual restart needed
- **No lint/typecheck/test**: This is a declarative QML project, not an application with a test suite

## Conventions

- **`//@ pragma UseQApplication`** in `main.qml` is required — do not remove it
- **`pragma Singleton`** is used for theme and service files so they can be imported and referenced globally
- **All theme values flow through `Style.qml`** — modules and components should never hardcode colors or metrics
- **Relative imports** use `../` to traverse up the directory tree (e.g., `import "../theme"`)
- **CavaService** depends on an external cava config at `/usr/share/skwd/ext/cava/cava-bar.conf` — this path is hardcoded
- **Colors config** is expected at `~/.config/quickshell/glassbar/colors.json` with Catppuccin-style schema: `{ "colors": { "dark": { "primary": "...", "secondary": "...", "tertiary": "...", "surface": "...", "surface_variant": "...", "outline": "...", "on_surface": "...", "on_surface_variant": "..." } } }` — watched for live reload

## Dependencies

- **Quickshell** (Qt Quick runtime for Wayland shells)
- **Hyprland** (IPC integration via `Quickshell.Hyprland`)
- **cava** (audio visualizer, optional — used by CavaService)
- **MPRIS** (media player control — used by MediaService)
