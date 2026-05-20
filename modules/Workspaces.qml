import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import "../components"
import "../theme"

Pill {
    id: root

    content: [

        Row {
            spacing: 8

            Repeater {
                model: Hyprland.workspaces

                Rectangle {
                    required property var modelData

                    readonly property int wsId:
                    modelData.id

                    readonly property bool isFocused:
                    modelData.focused

                    readonly property bool occupied:
                    modelData.lastIpcObject.windows > 0

                    property bool hovered:
                    mouse.containsMouse

                    width:
                    isFocused ? 20 : 8

                    height: 8

                    radius: 4

                    color:
                    isFocused
                    ? Style.primary
                    : occupied
                    ? Style.textPrimary
                    : Style.textMuted

                    opacity:
                    isFocused
                    ? 1.0
                    : hovered
                    ? 0.8
                    : 0.45

                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                            easing.type:
                            Easing.OutQuint
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }
                    }

                    MouseArea {
                        id: mouse

                        anchors.fill: parent

                        hoverEnabled: true

                        cursorShape:
                        Qt.PointingHandCursor

                        onClicked:
                        Hyprland.dispatch(
                        `workspace ${wsId}`
                        )
                    }
                }
            }
        }
    ]
}
