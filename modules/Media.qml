import QtQuick
import QtQuick.Layouts

import "../components"
import "../theme"
import "../services"

Pill {
    id: root

    visible: MediaService.active

    implicitWidth: 600
    implicitHeight: Style.barHeight

    // =========================
    // Fondo CAVA
    // =========================

    Rectangle {
        id: waveMask

        anchors.fill: parent

        radius: Style.pillRadius

        color: "transparent"

        clip: true

        Canvas {
            id: waves

            anchors.fill: parent

            opacity: 0.2

            visible:
            MediaService.playing

            Connections {
                target: CavaService

                function onBarsChanged() {
                    waves.requestPaint()
                }
            }

            onPaint: {

                let ctx =
                getContext("2d")

                ctx.reset()

                ctx.fillStyle =
                Style.primary

                let bars =
                CavaService.bars

                if (
                bars.length < 2
                )
                return

                let slice =
                width
                / (
                bars.length - 1
                )

                ctx.beginPath()

                ctx.moveTo(
                0,
                height
                )

                let firstY =
                height
                - (
                bars[0]
                / 100
                * height
                )

                ctx.quadraticCurveTo(
                0,
                height,

                slice * 0.5,

                firstY
                )

                for (
                let i = 1;
                i < bars.length;
                i++
                ) {

                    let x =
                    i * slice

                    let y =
                    height
                    - (
                    bars[i]
                    / 100
                    * height
                    )

                    let prevX =
                    (
                    i - 1
                    )
                    * slice

                    let prevY =
                    height
                    - (
                    bars[
                        i - 1
                    ]
                    / 100
                    * height
                    )

                    ctx.quadraticCurveTo(

                    prevX,

                    prevY,

                    (
                    prevX
                    + x
                    ) / 2,

                    (
                    prevY
                    + y
                    ) / 2
                    )
                }

                ctx.quadraticCurveTo(
                width,
                firstY,

                width,
                height
                )

                ctx.lineTo(
                width,
                height
                )

                ctx.closePath()

                ctx.fill()
            }

            Component.onCompleted:
            requestPaint()
        }
    }

    // =========================
    // Contenido
    // =========================

    RowLayout {

        anchors.fill: parent

        anchors.leftMargin: 15

        anchors.rightMargin: 15

        spacing: 12

        // Play pause

        Text {

            text:

            MediaService.playing
            ? "󰏤"
            : "󰐊"

            color:
            Style.primary

            font.pixelSize:
            16

            MouseArea {

                anchors.fill:
                parent

                onClicked:
                MediaService.playPause()
            }
        }

        // Artista

        Text {

            Layout.preferredWidth:
            120

            text:
            MediaService.artist

            color:
            Style.textPrimary

            font.family:
            Style.font

            font.pixelSize:
            11

            elide:
            Text.ElideRight
        }

        // Karaoke

        Item {

            Layout.fillWidth:
            true

            height:
            parent.height

            property string lyricText:

            LyricsService
            .currentLine
            !== ""

            ?

            LyricsService
            .currentLine

            :

            (
            "♪ "
            + MediaService.identity
            + " ♪"
            )

            // Base gris

            Text {

                id: lyricBase

                anchors.centerIn:
                parent

                text:
                parent.lyricText

                color:

                Qt.rgba(
                1,
                1,
                1,
                0.35
                )

                font.family:
                Style.font

                font.pixelSize:
                11

                font.italic:
                true
            }

            // Overlay izquierda -> derecha

            Item {

                x:
                lyricBase.x

                y:
                lyricBase.y

                width:

                lyricBase
                .contentWidth

                *

                LyricsService
                .lineProgress

                height:
                lyricBase.height

                clip: true

                Text {

                    x: 0

                    y: 0

                    text:
                    lyricBase.text

                    color:
                    Style.primary

                    font.family:
                    Style.font

                    font.pixelSize:
                    11

                    font.italic:
                    true
                }

                Behavior on width {

                    NumberAnimation {

                        duration:
                        120
                    }
                }
            }
        }

        // Título

        Text {

            Layout.preferredWidth:
            120

            text:
            MediaService.title

            color:
            Style.textPrimary

            font.family:
            Style.font

            font.pixelSize:
            11

            elide:
            Text.ElideRight

            horizontalAlignment:
            Text.AlignRight
        }
    }

    // =========================
    // Cambiar player
    // =========================

    MouseArea {

        anchors.fill:
        parent

        acceptedButtons:
        Qt.RightButton

        onClicked: (mouse) => {

            if (

            mouse.button
            === Qt.RightButton

            ) {

                MediaService
                .nextPlayer()
            }
        }
    }
}
