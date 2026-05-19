import QtQuick
import QtQuick.Layouts
import Quickshell

import "../theme"
import "../components"

Item {
    id: clockModule

    // =========================
    // Estado
    // =========================

    property bool popupOpen: false
    property date currentTime: new Date()
    readonly property var locale: Qt.locale("es_MX")

    // =========================
    // Tamaño
    // =========================

    implicitHeight: Style.barHeight
    implicitWidth: contentColumn.implicitWidth

    // =========================
    // Reset del mes al abrir el popup
    // =========================

    onPopupOpenChanged: {
        if (popupOpen)
            calendarView.viewedMonth = new Date(
                currentTime.getFullYear(),
                currentTime.getMonth(),
                1
            )
    }

    // =========================
    // Interacción
    // =========================

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            clockModule.popupOpen = !clockModule.popupOpen
        }
    }

    // =========================
    // Contenido reloj
    // =========================

    ColumnLayout {
        id: contentColumn

        anchors.fill: parent
        spacing: -2

        Text {
            Layout.alignment: Qt.AlignRight

            text: clockModule.currentTime.toLocaleTimeString(clockModule.locale, "HH:mm")

            color: Style.textPrimary
            font.family: Style.font
            font.pixelSize: 13
            font.weight: Font.DemiBold
            renderType: Text.NativeRendering
        }

        Text {
            Layout.alignment: Qt.AlignRight

            text: clockModule.currentTime.toLocaleDateString(clockModule.locale, "ddd d MMM").toUpperCase()

            color: Style.textMuted
            font.family: Style.font
            font.pixelSize: 9
            renderType: Text.NativeRendering
        }
    }

    // =========================
    // Popup calendario
    // =========================

    PopupWindow {
        id: calendarPopup

        visible: clockModule.popupOpen
        color: "transparent"
        grabFocus: true

        implicitWidth: 260
        implicitHeight: calendarView.implicitHeight + 30

        anchor {
            item: clockModule
            edges: Edges.Bottom | Edges.Right
            gravity: Edges.Bottom | Edges.Left
        }

        Rectangle {
            anchors.fill: parent
            radius: Style.radius
            color: Style.pillBg
            border.color: Style.pillBorder
            border.width: 1

            CalendarView {
                id: calendarView

                anchors.fill: parent
                anchors.margins: 15

                currentTime: clockModule.currentTime
                locale: clockModule.locale
            }
        }
    }

    // =========================
    // Actualización del reloj
    // =========================

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            let now = new Date()

            if (now.getMinutes() !== clockModule.currentTime.getMinutes()) {
                clockModule.currentTime = now
            }
        }
    }
}
