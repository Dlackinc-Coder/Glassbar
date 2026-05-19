pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false

    property int barCount: 14

    property var bars: Array(barCount).fill(0)

    property var smoothBars: Array(barCount).fill(0)

    Process {
        id: cava

        command: [
            "cava",
            "-p",
            "/usr/share/skwd/ext/cava/cava-bar.conf"
        ]

        running: true

        stdout: SplitParser {

            onRead: data => {

                let vals =
                data.trim()
                .split(";")
                .filter(
                v => v !== ""
                )
                .map(
                v =>
                parseInt(v)
                || 0
                )

                if (
                vals.length === 0
                )
                return

                let smoothed = []

                for (
                let i = 0;
                i < root.barCount;
                i++
                ) {

                    let target =
                    vals[i] ?? 0

                    let old =
                    root.smoothBars[i]
                    ?? 0

                    smoothed.push(
                    old
                    + (
                    target
                    - old
                    ) * 0.25
                    )
                }

                root.smoothBars =
                smoothed

                root.bars =
                smoothed
            }
        }

        onExited:
        restartTimer.start()
    }

    Timer {
        id: restartTimer

        interval: 2000

        onTriggered:
        cava.running = true
    }
}
