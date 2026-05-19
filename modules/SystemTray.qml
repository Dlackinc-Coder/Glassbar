import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

import "../components"
import "../theme"

Pill {
    id: root

    visible:
        trayRepeater.count > 0

    opacity:
        visible ? 1.0 : 0.0

    Behavior on opacity {
        NumberAnimation {
            duration: 150
        }
    }

    implicitWidth:
        layout.implicitWidth
        + (
            Style.contentMargin * 2
        )

    implicitHeight:
        Style.barHeight

    content: [

        RowLayout {
            id: layout

            Layout.alignment:
                Qt.AlignCenter

            Repeater {
                id: trayRepeater

                model:
                    SystemTray.items

                delegate:
                    TrayItem {
                        item:
                            modelData
                    }
            }
        }
    ]
}