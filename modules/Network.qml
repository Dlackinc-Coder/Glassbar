import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Networking

import "../components"
import "../theme"

Pill {
    id: root

    readonly property var devices:
        Networking.devices
            ? Networking.devices.values
            : []

    readonly property WifiDevice wifi: {
        if (!devices)
            return null

        for (const device of devices) {
            if (device.type === DeviceType.Wifi)
                return device
        }

        return null
    }

    readonly property real strength: {
        if (wifi && wifi.activeNetwork) {
            return wifi.activeNetwork.signalStrength
        }

        if (wifi && wifi.networks) {
            const connectedNetwork =
                wifi.networks.values.find(
                    network => network.connected
                )

            return connectedNetwork
                ? connectedNetwork.signalStrength
                : 0
        }

        return 0
    }

    readonly property real normalizedStrength:
        strength > 1
        ? strength / 100
        : strength

    readonly property string ssid: {

        if (!wifi)
            return "Buscando..."

        if (
            wifi.activeNetwork
            && wifi.activeNetwork.name
        ) {
            return wifi.activeNetwork.name
        }

        if (wifi.networks) {
            for (
                const network
                of wifi.networks.values
            ) {
                if (network.connected)
                    return network.name
            }
        }

        if (
            wifi.activeConnection
            && wifi.activeConnection.name
        ) {
            return wifi.activeConnection.name
        }

        return wifi.connected
            ? "Conectado"
            : "Desconectado"
    }

    readonly property bool connected:
        wifi && wifi.connected

    readonly property color signalColor:
        connected
        ? Style.accentGreen
        : Style.accentRed

    content: [

        Row {
            spacing: 2
            height: 10

            Repeater {
                model: 4

                Rectangle {
                    width: 3

                    height:
                        4 + (index * 2)

                    radius: 1

                    anchors.bottom:
                        parent.bottom

                    color:
                        index <
                        Math.ceil(
                            root.normalizedStrength
                            * 4
                        )
                        && root.connected
                        ? root.signalColor
                        : Style.textMuted

                    Behavior on color {
                        ColorAnimation {
                            duration: 180
                        }
                    }
                }
            }
        },

        Text {
            width: 90

            text: root.ssid

            elide:
                Text.ElideRight

            color:
                root.signalColor

            font.family:
                Style.font

            font.pixelSize:
                12

            renderType:
                Text.NativeRendering
        }
    ]
}