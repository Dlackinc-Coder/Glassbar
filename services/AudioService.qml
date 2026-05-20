pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false

    property int volume: 0

    function refresh() {

        proc.command = [
            "wpctl",
            "get-volume",
            "@DEFAULT_AUDIO_SINK@"
        ]

        proc.running = true
    }

    function setVolume(v) {

        volume = Math.round(v)

        setProc.command = [
            "wpctl",
            "set-volume",
            "@DEFAULT_AUDIO_SINK@",
            (v / 100).toString()
        ]

        setProc.running = true
    }

    Process {
        id: proc

        stdout: SplitParser {

            onRead: data => {

                let m =
                data.match(
                /([0-9.]+)/
                )

                if (m) {

                    root.volume =
                    Math.round(
                    parseFloat(
                    m[1]
                    ) * 100
                    )
                }
            }
        }
    }

    Process {
        id: setProc
    }

    Timer {
        interval: 1500
        running: true
        repeat: true

        onTriggered:
        root.refresh()
    }

    Component.onCompleted:
    refresh()
}
