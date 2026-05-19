pragma Singleton

import QtQuick
import "./"

QtObject {
    id: style

    // -------------------------
    // Typography
    // -------------------------

    readonly property string font:      Typography.family
    readonly property int clockSize:    Typography.clockSize
    readonly property int smallSize:    Typography.smallSize

    // -------------------------
    // Material colors
    // -------------------------

    readonly property color primary:        Colors.primary
    readonly property color secondary:      Colors.secondary
    readonly property color tertiary:       Colors.tertiary
    readonly property color surface:        Colors.surface
    readonly property color surfaceVariant: Colors.surfaceVariant
    readonly property color outline:        Colors.outline
    readonly property color onSurface:      Colors.onSurface
    readonly property color onSurfaceVariant: Colors.onSurfaceVariant

    // -------------------------
    // Adaptive glass colors
    // -------------------------

    readonly property color glassBg:      Appearance.glassBg
    readonly property color glassBorder:  Appearance.glassBorder
    readonly property color pillBg:       Appearance.pillBg
    readonly property color pillBorder:   Appearance.pillBorder

    // -------------------------
    // Text
    // -------------------------

    readonly property color textPrimary: Appearance.textPrimary
    readonly property color textMuted:   Appearance.textMuted

    // -------------------------
    // Accent
    // -------------------------

    readonly property color accent:      Colors.primary
    readonly property color accentGreen: Appearance.accentGreen
    readonly property color accentRed:   Appearance.accentRed
    readonly property color accentTeal:  Colors.tertiary
    readonly property color accentBg:    Appearance.accentBg

    // -------------------------
    // Metrics
    // -------------------------

    readonly property int barHeight:     Metrics.barHeight
    readonly property int radius:        Metrics.radius
    readonly property int pillRadius:    Metrics.pillRadius
    readonly property int spacing:       Metrics.spacing
    readonly property int outerMargin:   Metrics.outerMargin
    readonly property int contentMargin: Metrics.contentMargin
    readonly property int dividerMargin: Metrics.dividerMargin
}