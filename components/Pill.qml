import QtQuick
import QtQuick.Layouts
import "../theme"

Rectangle {
    id: pill

    // CAMBIO
    property alias content: inner.data

    property color bgColor: Style.pillBg
    property color borderColor: Style.pillBorder

    color: bgColor

    radius: Style.pillRadius

    implicitHeight: Style.barHeight

    implicitWidth:
        inner.implicitWidth
        + Style.spacing * 2

    Rectangle {
        id: borderLayer

        anchors.fill: parent

        color: "transparent"

        border.color: pill.borderColor
        border.width: 1

        radius: pill.radius
    }

    Item {
        id: clipper

        anchors.fill: parent

        clip: true

        RowLayout {
            id: inner

            anchors.fill: parent

            anchors.leftMargin: Style.spacing
            anchors.rightMargin: Style.spacing

            spacing: Style.spacing / 2

            Layout.alignment: Qt.AlignVCenter
        }
    }
}