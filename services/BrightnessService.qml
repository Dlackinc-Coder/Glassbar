pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false

    property int brightness: 50

    property int maxBrightness: 100

    function refresh() {

        getCurrent.running = true
        getMax.running = true
    }

    function updatePercent(raw) {

        if (maxBrightness <= 0)
        return

        brightness =
        Math.round(
        raw * 100
        / maxBrightness
        )
    }

    function setBrightness(v) {

        brightness = Math.round(v)

        setProc.command = [
            "brightnessctl",
            "s",
            brightness + "%"
        ]

        setProc.running = true
    }

    Process {
        id: getCurrent

        command: [
            "brightnessctl",
            "g"
        ]

        stdout: SplitParser {

            onRead: data => {

                updatePercent(
                parseInt(
                data.trim()
                )
                )
            }
        }
    }

    Process {
        id: getMax

        command: [
            "brightnessctl",
            "m"
        ]

        stdout: SplitParser {

            onRead: data => {

                root.maxBrightness =
                parseInt(
                data.trim()
                ) || 100
            }
        }
    }

    Process {
        id: setProc
    }

    Component.onCompleted:
    refresh()
}
