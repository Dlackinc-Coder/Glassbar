import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../theme"
import "../services"

RowLayout {
    id: root

    anchors.fill: parent
    anchors.margins: 12
    spacing: 12

    readonly property bool isInteracting: audioSlider.pressed || brightnessSlider.pressed

    // =========================================================================
    // AUDIO (Volumen con Icono Flotante Sólido)
    // =========================================================================
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Slider {
            id: audioSlider
            orientation: Qt.Vertical
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 140
            from: 0
            to: 100
            value: AudioService.volume
            onMoved: AudioService.setVolume(value)

            background: Rectangle {
                id: audioBg
                x: audioSlider.topPadding + audioSlider.availableWidth / 2 - width / 2
                y: audioSlider.topPadding
                implicitWidth: 6
                implicitHeight: 140
                width: 6
                height: audioSlider.availableHeight
                radius: 4
                color: Style.glassBorder
                clip: true

                // Barra de progreso interna
                Rectangle {
                    width: parent.width
                    height: audioSlider.visualPosition === 0
                    ? parent.height - 1
                    : (1 - audioSlider.visualPosition) * parent.height
                    radius: 4
                    anchors.bottom: parent.bottom
                    color: Style.secondary
                }
            }

            // EL HANDLE CORREGIDO (Sólido)
            handle: Rectangle {
                x: audioSlider.topPadding + audioSlider.availableWidth / 2 - width / 2
                y: audioSlider.topPadding + audioSlider.visualPosition * (audioSlider.availableHeight - height)

                implicitWidth: 26
                implicitHeight: 26
                radius: 13

                color: audioSlider.pressed ? Style.primary : (audioSlider.hovered ? Style.secondary : "#1e1e2e")
                border.color: audioSlider.pressed || audioSlider.hovered ? Style.outline : Style.glassBorder
                border.width: 1

                scale: audioSlider.pressed ? 1.15 : (audioSlider.hovered ? 1.05 : 1.0)
                Behavior on scale { NumberAnimation { duration: 120 } }
                Behavior on color { ColorAnimation { duration: 180 } }

                Text {
                    anchors.centerIn: parent
                    text: "󰕾"
                    font.pixelSize: 14
                    color: audioSlider.pressed ? "#11111b" : Style.textPrimary
                }
            }
        }

        // Porcentaje numérico sutil abajo
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: AudioService.volume + "%"
            color: Style.textPrimary
            font.family: Style.font
            font.pixelSize: 10
            font.weight: Font.Medium
            opacity: audioSlider.hovered || audioSlider.pressed ? 1.0 : 0.6
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
    }

    // Separador Central
    Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        Layout.topMargin: 12
        Layout.bottomMargin: 12
        color: Style.glassBorder
    }

    // =========================================================================
    // BRILLO (Luminosidad con Icono Flotante Sólido)
    // =========================================================================
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        spacing: 6

        Slider {
            id: brightnessSlider
            orientation: Qt.Vertical
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 140
            from: 0
            to: 100
            value: BrightnessService.brightness
            onMoved: BrightnessService.setBrightness(value)

            background: Rectangle {
                x: brightnessSlider.topPadding + brightnessSlider.availableWidth / 2 - width / 2
                y: brightnessSlider.topPadding
                implicitWidth: 6
                implicitHeight: 140
                width: 6
                height: brightnessSlider.availableHeight
                radius: 4
                color: Style.glassBorder

                clip: true

                Rectangle {
                    width: parent.width
                    height: brightnessSlider.visualPosition === 0
                    ? parent.height - 1
                    : (1 - brightnessSlider.visualPosition) * parent.height
                    radius: 4
                    anchors.bottom: parent.bottom
                    color: Style.tertiary
                }
            }

            handle: Rectangle {
                x: brightnessSlider.topPadding + brightnessSlider.availableWidth / 2 - width / 2
                y: brightnessSlider.topPadding + brightnessSlider.visualPosition * (brightnessSlider.availableHeight - height)

                implicitWidth: 26
                implicitHeight: 26
                radius: 13

                color: brightnessSlider.pressed ? Style.primary : (brightnessSlider.hovered ? Style.tertiary : "#1e1e2e")
                border.color: brightnessSlider.pressed || brightnessSlider.hovered ? Style.outline : Style.glassBorder
                border.width: 1

                scale: brightnessSlider.pressed ? 1.15 : (brightnessSlider.hovered ? 1.05 : 1.0)
                Behavior on scale { NumberAnimation { duration: 120 } }
                Behavior on color { ColorAnimation { duration: 180 } }

                Text {
                    anchors.centerIn: parent
                    text: "󰃠"
                    font.pixelSize: 14
                    color: brightnessSlider.pressed ? "#11111b" : Style.textPrimary
                }
            }
        }

        // Porcentaje numérico abajo
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: BrightnessService.brightness + "%"
            color: Style.textPrimary
            font.family: Style.font
            font.pixelSize: 10
            font.weight: Font.Medium
            opacity: brightnessSlider.hovered || brightnessSlider.pressed ? 1.0 : 0.6
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
    }
}
