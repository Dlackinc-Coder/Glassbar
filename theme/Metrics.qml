pragma Singleton

import QtQuick

QtObject {
    id: metrics

    // Bar dimensions
    readonly property int barHeight: 32

    // Border radii
    readonly property int radius:     14
    readonly property int pillRadius: 20

    // Spacing
    readonly property int spacing: 8

    // Margins
    readonly property int outerMargin:    5
    readonly property int contentMargin:  12
    readonly property int dividerMargin:  8
}