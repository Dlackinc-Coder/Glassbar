pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import "../services"

Item {
    id: root

    visible: false

    // =========================
    // Estado
    // =========================

    property var lyrics: []

    property string currentLine: ""

    property real lineProgress: 0

    property string trackKey: ""

    property bool loading: false

    property real position: 0

    // =========================
    // Canción actual
    // =========================

    readonly property string title:
    MediaService.title

    readonly property string artist:
    MediaService.artist

    // =========================
    // Detectar cambio
    // =========================

    onTitleChanged:
    updateTrack()

    onArtistChanged:
    updateTrack()

    function updateTrack() {

        if (!title || !artist)
        return

        let key =
        artist
        + "-"
        + title

        if (key === trackKey)
        return

        trackKey = key

        fetchLyrics()
    }

    // =========================
    // Descargar letra
    // =========================

    function fetchLyrics() {

        loading = true

        lyrics = []

        currentLine = ""

        lineProgress = 0

        position = 0

        console.log(
        "Searching lyrics:",
        artist,
        "-",
        title
        )

        let url =
        "https://lrclib.net/api/search?"
        + "track_name="
        + encodeURIComponent(title)
        + "&artist_name="
        + encodeURIComponent(artist)

        console.log(url)

        curl.command = [
            "curl",
            "-L",
            "-s",
            url
        ]

        curl.running = true
    }

    // =========================
    // Parse LRC
    // =========================

    function parseLrc(text) {

        let result = []

        let lines =
        text.split("\n")

        for (
        let line of lines
        ) {

            let m =
            line.match(
            /\[(\d+):(\d+\.\d+)\](.*)/
            )

            if (!m)
            continue

            let time =
            parseInt(
            m[1]
            )
            * 60

            +

            parseFloat(
            m[2]
            )

            result.push({

                time: time,

                text:
                m[3].trim()
            })
        }

        lyrics = result

        console.log(
        "Parsed:",
        lyrics.length
        )
    }

    // =========================
    // Actualizar línea
    // =========================

    function updateLyrics() {

        if (
        lyrics.length < 2
        )
        return

        for (
        let i = 0;
        i < lyrics.length - 1;
        i++
        ) {

            let cur =
            lyrics[i]

            let next =
            lyrics[
                i + 1
            ]

            if (

            position
            >= cur.time

            &&

            position
            < next.time

            ) {

                currentLine =
                cur.text

                lineProgress =

                (
                position
                - cur.time
                )

                /

                (
                next.time
                - cur.time
                )

                return
            }
        }
    }

    // =========================
    // Sync MPRIS
    // =========================

    Timer {

        interval: 250

        running:
        MediaService.playing

        repeat: true

        onTriggered: {

            if (
            !MediaService.player
            )
            return

            let p =
            MediaService
            .player
            .position

            // μs
            if (p > 100000)
            p /= 1000000

            // ms
            else if (
            p > 1000
            )
            p /= 1000

            root.position = p

            root.updateLyrics()
        }
    }

    // =========================
    // CURL
    // =========================

    Process {
        id: curl

        stdout: SplitParser {

            onRead: data => {

                try {

                    let json =
                    JSON.parse(
                    data
                    )

                    if (
                    json.length
                    === 0
                    ) {

                        root.loading =
                        false

                        return
                    }

                    let lrc =

                    json[0]
                    .syncedLyrics

                    if (!lrc) {

                        root.loading =
                        false

                        return
                    }

                    root.parseLrc(
                    lrc
                    )

                    root.updateLyrics()

                } catch(e) {

                    console.log(
                    "Lyrics error:",
                    e
                    )
                }

                root.loading = false
            }
        }
    }
}
