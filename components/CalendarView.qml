import QtQuick
import QtQuick.Layouts
import "../theme"

ColumnLayout {
    id: calendarRoot

    spacing: 15

    // =========================
    // API pública del componente
    // =========================

    property date currentTime: new Date()
    property var locale: Qt.locale("es_MX")

    // =========================
    // Estado interno
    // =========================

    property date viewedMonth: new Date(currentTime.getFullYear(), currentTime.getMonth(), 1)

    readonly property int year: viewedMonth.getFullYear()
    readonly property int month: viewedMonth.getMonth()
    readonly property int daysInMonth: new Date(year, month + 1, 0).getDate()

    readonly property int firstDayOfMonth: (new Date(year, month, 1).getDay() + 6) % 7

    readonly property int weeksInMonth: Math.ceil((firstDayOfMonth + daysInMonth) / 7)

    implicitHeight: 30 + 15 + 16 + 15 + (weeksInMonth * 34)

    // =========================
    // Header navegación
    // =========================

    RowLayout {
        Layout.fillWidth: true

        // Mes anterior
        Item {
            implicitWidth: 30
            implicitHeight: 30

            Text {
                anchors.centerIn: parent
                text: ""
                color: Style.textPrimary
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    calendarRoot.viewedMonth = new Date(calendarRoot.year, calendarRoot.month - 1, 1)
                }
            }
        }

        Item { Layout.fillWidth: true }

        Text {
            text: calendarRoot.viewedMonth.toLocaleDateString(calendarRoot.locale, "MMMM yyyy").toUpperCase()

            color: Style.textPrimary
            font.family: Style.font
            font.pixelSize: 12
            font.weight: Font.DemiBold
        }

        Item { Layout.fillWidth: true }

        // Mes siguiente
        Item {
            implicitWidth: 30
            implicitHeight: 30

            Text {
                anchors.centerIn: parent
                text: ""
                color: Style.textPrimary
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    calendarRoot.viewedMonth = new Date(calendarRoot.year, calendarRoot.month + 1, 1)
                }
            }
        }
    }

    // =========================
    // Días de la semana
    // =========================

    RowLayout {
        Layout.fillWidth: true

        Repeater {
            model: ["L", "M", "M", "J", "V", "S", "D"]

            Text {
                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
                text: modelData

                color: Style.textMuted
                font.family: Style.font
                font.pixelSize: 10
                font.weight: Font.Bold
            }
        }
    }

    // =========================
    // Grid calendario
    // =========================

    GridLayout {
        columns: 7

        Layout.fillWidth: true

        columnSpacing: 4
        rowSpacing: 4

        Repeater {
            model: calendarRoot.firstDayOfMonth + calendarRoot.daysInMonth

            Rectangle {
                readonly property int dayNumber: index - calendarRoot.firstDayOfMonth + 1
                readonly property bool isValid: dayNumber > 0 && dayNumber <= calendarRoot.daysInMonth
                readonly property bool isToday: (
                    calendarRoot.year === calendarRoot.currentTime.getFullYear() &&
                    calendarRoot.month === calendarRoot.currentTime.getMonth() &&
                    dayNumber === calendarRoot.currentTime.getDate()
                )

                Layout.fillWidth: true
                implicitHeight: 30

                radius: 8

                color: isToday ? Style.accentBg : (hovered ? Style.pillBorder : "transparent")

                border.width: isToday ? 1 : 0
                border.color: isToday ? Qt.rgba(Style.primary.r, Style.primary.g, Style.primary.b, 0.35) : "transparent"

                property bool hovered: false

                Behavior on color {
                    ColorAnimation { duration: 100 }
                }

                Text {
                    anchors.centerIn: parent

                    text: isValid ? dayNumber : ""

                    color: isToday ? Style.primary : (isValid ? Style.textPrimary : "transparent")

                    font.family: Style.font
                    font.pixelSize: 10
                    font.weight: isToday ? Font.Bold : Font.Normal
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: isValid
                    cursorShape: isValid ? Qt.PointingHandCursor : Qt.ArrowCursor

                    onEntered: if (isValid) parent.hovered = true
                    onExited: parent.hovered = false
                }
            }
        }
    }
}
