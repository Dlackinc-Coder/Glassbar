pragma Singleton

import QtQuick
import Quickshell
import "./"

QtObject {
    id: colors

    function scheme() {
        if (ThemeLoader.colors && ThemeLoader.colors.colors && ThemeLoader.colors.colors.dark) {
            return ThemeLoader.colors.colors.dark
        }
        return {}
    }

    readonly property var dark: scheme()

    readonly property color primary: dark.primary || "#a78bfa"
    readonly property color secondary: dark.secondary || "#89b4fa"
    readonly property color tertiary: dark.tertiary || "#60d9d0"
    readonly property color surface: dark.surface || "#11111b"
    readonly property color surfaceVariant: dark.surface_variant || "#1e1e2e"
    readonly property color outline: dark.outline || "#6c7086"
    readonly property color onSurface: dark.on_surface || "#ffffff"
    readonly property color onSurfaceVariant: dark.on_surface_variant || "#cdd6f4"
}
