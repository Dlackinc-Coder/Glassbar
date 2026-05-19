import QtQuick
import "../theme"

Rectangle {
    id: root

    color: Style.glassBg

    radius: Style.radius

    border.color: Style.glassBorder
    border.width: 1

    clip: true

    // =========================
    // Inner highlight
    // =========================

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1

        radius: root.radius - 1

        color: Qt.rgba(1, 1, 1, 0.03)
    }

    // =========================
    // Top light gradient
    // =========================

    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: parent.height * 0.45

        radius: root.radius

        color: Qt.rgba(1, 1, 1, 0.04)
    }
}