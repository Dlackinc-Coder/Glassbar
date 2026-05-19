import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import "../components"
import "../modules"
import "../theme"
import "../services"

PanelWindow {
    id: bar

    implicitHeight:
        Style.barHeight + 20

    anchors {
        top: true
        left: true
        right: true
    }

    WlrLayershell.layer:
        WlrLayer.Top

    color: "transparent"

    GlassPanel {
        anchors.fill: parent

        anchors.margins:
            Style.outerMargin

        Item {
            anchors.fill: parent

            // =====================
            // IZQUIERDA
            // =====================

            RowLayout {
                anchors {
                    left: parent.left

                    leftMargin: Style.contentMargin

                    verticalCenter: parent.verticalCenter
                }

                spacing: Style.spacing

                IconApp {}

                Workspaces {}

                Divider {}
            }

            // =====================
            // CENTRO ABSOLUTO
            // =====================

            Media {
                anchors.centerIn: parent
            }

            // =====================
            // DERECHA
            // =====================

            RowLayout {
                anchors {
                    right: parent.right

                    rightMargin: Style.contentMargin

                    verticalCenter: parent.verticalCenter
                }

                spacing: Style.spacing

                SystemTray {}

                Network {}

                Battery {}

                Divider {}

                Clock {}
            }
        }
    }
}