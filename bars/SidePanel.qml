import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import "../components"
import "../theme"
import "../modules"

PanelWindow {
    id: panel

    anchors {
        top: true
        bottom: true
        right: true
    }

    exclusionMode: ExclusionMode.Ignore
    exclusiveZone: 0
    aboveWindows: true
    WlrLayershell.layer: WlrLayer.Overlay
    color: "transparent"

    // Cambia de golpe para que Hyprland asigne el espacio físico sin micro-pasos
    implicitWidth: panel.expanded ? 150 : 6

    property bool expanded: false

    // =========================================================================
    // SENSOR DE RATÓN INTERNO
    // =========================================================================
    MouseArea {
        id: globalMouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            hideTimer.stop()
            panel.expanded = true
        }

        onExited: {
            if (!quickSettings.isInteracting) {
                hideTimer.start()
            }
        }
    }

    // =========================================================================
    // CONTENEDOR VISUAL CON ANIMACIÓN SUAVE
    // =========================================================================
    // =========================================================================
    // CONTENEDOR VISUAL CON ANIMACIÓN SUAVE (Simetría Corregida)
    // =========================================================================
    Item {
        id: animContainer
        anchors.fill: parent
        clip: true

        // Este contenedor intermedio SIEMPRE mide 150px.
        // Al tener un tamaño fijo, todo lo que metas dentro mantendrá su simetría.
        Item {
            id: contentWrapper
            width: 150
            height: parent.height
            anchors.right: parent.right

            // Animamos la posición X para esconder o mostrar el bloque completo
            x: panel.expanded ? 0 : 144

            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            // Tu panel de cristal ahora se alinea respecto a los 150px fijos
            GlassPanel {
                id: glass
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 110
                height: 240

                // Obligamos a que QuickSettings ocupe exactamente el área simétrica del GlassPanel
                QuickSettings {
                    id: quickSettings
                    anchors.fill: parent
                    anchors.margins: 8 // Margen interno opcional para que nada toque los bordes
                }
            }
        }
    }

    // =========================================================================
    // EL TEMPORIZADOR ANTI-PARPADEO
    // =========================================================================
    Timer {
        id: hideTimer
        interval: 350
        repeat: false

        onTriggered: {
            if (!globalMouseArea.containsMouse && !quickSettings.isInteracting) {
                panel.expanded = false
            }
        }
    }

    Connections {
        target: quickSettings
        function onIsInteractingChanged() {
            if (!quickSettings.isInteracting && !globalMouseArea.containsMouse) {
                hideTimer.start()
            }
        }
    }
}
