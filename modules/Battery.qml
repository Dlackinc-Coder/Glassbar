import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower

import "../theme"
import "../components"

Pill {
    id: root

    readonly property var battery: UPower.displayDevice

    readonly property color accentColor: {

        if (
        root.percent <= 20
        )
        return Style.accentRed

        if (
        root.percent <= 50
        )
        return "#facc15"

        return Style.accentGreen
    }

    readonly property real rawPercent: battery.ready ? battery.percentage : 0

    readonly property int percent: rawPercent <= 1.0 ? Math.round( rawPercent * 100) : Math.round(rawPercent)

    readonly property bool charging: battery.ready && (battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.PendingCharge)

    readonly property bool full: battery.ready && (battery.state=== UPowerDeviceState.FullyCharged)

    readonly property bool discharging: battery.ready && ( battery.state === UPowerDeviceState.Discharging || battery.state === UPowerDeviceState.PendingDischarge)

    bgColor: root.percent <= 20 ? Qt.rgba( accentColor.r,accentColor.g, accentColor.b, 0.2 ) : Style.pillBg

    content: [

        Rectangle {

            implicitWidth: 18
            implicitHeight: 10

            color: "transparent"

            border.color: root.percent <= 20 ? root.accentColor : "#888888"

            border.width: 1.5

            radius: 2

            // Terminal batería
            Rectangle {

                anchors {
                    right: parent.right
                    rightMargin: -3
                    verticalCenter: parent.verticalCenter
                }

                width: 2

                height: 5

                radius: 1

                color: parent.border.color
            }

            // Nivel
            Rectangle {

                anchors {
                    left:parent.left
                    leftMargin: 2
                    verticalCenter: parent.verticalCenter
                }

                width: ( parent.width - 4 ) * ( root.percent / 100)

                height: 6

                radius: 1

                color: root.accentColor

                Behavior on width {

                    NumberAnimation {
                        duration: 300
                    }
                }
            }
        },

        Text {

            renderType: Text.NativeRendering

            font.family: Style.font

            font.pixelSize: 12

            color: root.percent <= 20 ? root.accentColor : Style.textPrimary

            text:( root.full ? "󰁹 " : root.charging ? "󱐋 " : root.discharging ? "" : "󰂑 ") + root.percent + "%"
        }
    ]
}
