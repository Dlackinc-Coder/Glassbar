pragma Singleton

import QtQuick
import Quickshell.Services.Mpris

QtObject {
    id: root

    // =========================
    // Todos los players
    // =========================

    readonly property var allPlayers:
        Mpris.players
            ? Mpris.players.values
            : []

    // =========================
    // Players válidos
    // (ignora players vacíos/fantasma)
    // =========================

    readonly property var players: {
        let result = []

        for (let p of allPlayers) {

            if (!p)
                continue

            let hasMetadata =
                (p.trackTitle && p.trackTitle !== "") ||
                (p.trackArtist && p.trackArtist !== "")

            if (!hasMetadata)
                continue

            result.push(p)
        }

        return result
    }

    // =========================
    // Player manual
    // =========================

    property var manualPlayer: null

    // =========================
    // Player activo
    // =========================

    readonly property var player: {

        if (manualPlayer && players.includes(manualPlayer))
            return manualPlayer

        for (let p of players) {
            if (p.isPlaying)
                return p
        }

        if (players.length > 0)
            return players[0]

        return null
    }

    // =========================
    // Estado
    // =========================

    readonly property bool active: player !== null

    readonly property string title: active ? player.trackTitle : ""

    readonly property string artist: active ? player.trackArtist : ""

    readonly property string artUrl: active ? player.trackArtUrl : ""

    readonly property bool playing: active ? player.isPlaying : false

    readonly property string identity: active ? player.identity : ""

    // =========================
    // Controles
    // =========================

    function playPause() {
        if (player && player.canTogglePlaying)
            player.togglePlaying()
    }

    function next() {
        if (player && player.canGoNext)
            player.next()
    }

    function previous() {
        if (player && player.canGoPrevious)
            player.previous()
    }

    // =========================
    // Cambiar player manualmente
    // =========================

    function nextPlayer() {

        if (players.length <= 1)
            return

        let currentIndex = players.indexOf(player)

        if (currentIndex === -1)
            currentIndex = 0

        let nextIndex =
            (currentIndex + 1) % players.length

        manualPlayer = players[nextIndex]

    }

    // =========================
    // Volver a modo automático
    // =========================

    function resetAutoPlayer() {
        manualPlayer = null
    }

    // =========================
    // Limpieza automática
    // =========================

    onPlayersChanged: {

        if (
            manualPlayer &&
            !players.includes(manualPlayer)
        ) {
            manualPlayer = null
        }
    }
}