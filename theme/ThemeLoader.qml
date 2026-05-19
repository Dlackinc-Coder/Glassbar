pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: themeLoader

    property var colors: ({
        "colors": {
            "dark": {
                "primary": "#a78bfa",
                "secondary": "#89b4fa",
                "tertiary": "#60d9d0",
                "surface": "#11111b",
                "surface_variant": "#1e1e2e",
                "outline": "#6c7086",
                "on_surface": "#ffffff",
                "on_surface_variant": "#cdd6f4"
            }
        }
    })

    property FileView fileView: FileView {
        id: colorsFile
        path: "file://" + Quickshell.env("HOME") + "/.config/quickshell/glassbar/colors.json"

        preload: true
        watchChanges: true

        onLoaded: themeLoader.reload()
        onFileChanged: themeLoader.reload()
    }

    function reload() {
        try {
            let raw = colorsFile.text().trim()
            if (raw) {
                themeLoader.colors = JSON.parse(raw)
            }
        } catch (e) {
            console.log("ThemeLoader Error:", e)
        }
    }
}