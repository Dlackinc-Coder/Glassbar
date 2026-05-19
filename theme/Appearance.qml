pragma Singleton

import QtQuick
import "./"

QtObject {
    id: appearance

    // -------------------------
    // Glass
    // -------------------------

    readonly property color glassBg:      Qt.rgba(1, 1, 1, 0.04)
    readonly property color glassBorder:  Qt.rgba(1, 1, 1, 0.060)
    readonly property color pillBg:       Qt.rgba(1, 1, 1, 0.060)
    readonly property color pillBorder:   Qt.rgba(1, 1, 1, 0.100)

    // -------------------------
    // Text
    // -------------------------

    readonly property color textPrimary:  Qt.rgba(1, 1, 1, 0.920)
    readonly property color textMuted:    Qt.rgba(1, 1, 1, 0.450)

    // -------------------------
    // Accents
    // -------------------------

    readonly property color accentGreen:  "#6dde8b"
    readonly property color accentRed:    "#ff6b8a"

    readonly property color accentBg: Qt.rgba(
    Colors.primary.r,
    Colors.primary.g,
    Colors.primary.b,
    0.18
    )
}
