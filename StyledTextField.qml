import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: root
    property bool hasError: false

    background: Rectangle {
        border.color: root.hasError ? "#ff4444" : (root.activeFocus ? "#21be2b" : "#cccccc")
        border.width: root.hasError ? 2 : 1
        radius: 4
        color: "transparent"

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }
    }
}
