import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Item {
    id: root
    property SystemTrayItem item: null

        width: 24
        height: 24

        Image {
            sourceSize.width: width
            sourceSize.height: height
            anchors.fill: parent
            source: root.item ? root.item.icon : ""
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true

            retainWhileLoading: true
        }


        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: (mouse) => {
            if (!root.item) return;

            if (mouse.button === Qt.RightButton)
            {
                if (root.item.hasMenu)
                {
                    let coords = mapToItem(null, mouse.x, mouse.y);
                    root.item.display(root.QsWindow.window, coords.x, coords.y);
                }
            } else {
            root.item.activate();
        }
    }
}
}