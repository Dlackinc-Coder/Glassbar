import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import "../theme"
import "../components"

Pill {
    id: root

    property string appId: ""
    property string title: ""

    Connections {
        target: Hyprland

        function cleanAppId(id) {
            if (!id)
                return ""

            return id
                .split(",")[0]
                .trim()
                .toLowerCase()
        }

        function onRawEvent(event) {
            if (
                event.name
                !== "activewindow"
            )
                return

            const parts =
                event.data.split(",")

            const newApp =
                cleanAppId(parts[0])

            if (newApp === appId)
                return

            appId = newApp

            title =
                parts[1] ?? ""
        }
    }

    content: [

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.margins:
                Style.spacing / 2

            implicitWidth: 18
            implicitHeight: 18

            Image {
                id: icon

                anchors.centerIn:
                    parent

                width: 18
                height: 18

                fillMode:
                    Image.PreserveAspectFit

                sourceSize.width:
                    32

                sourceSize.height:
                    32

                source:
                    appId
                    ? Quickshell.iconPath(
                        appId
                    )
                    : Quickshell.iconPath(
                        "application-x-executable"
                    )
            }
        }
    ]
}