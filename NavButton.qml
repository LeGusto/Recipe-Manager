import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {

    background: Rectangle {
        color: parent.hovered ? "#b37c11" : "#E9A319"
        border.color: "#E9A319"
        border.width: 2

        Behavior on color {
            ColorAnimation {
                duration: 200 // Animation time in milliseconds
                easing.type: Easing.InOutQuad // Smooth easing
            }
        }
    }
    font.pixelSize: 16

    Component.onCompleted: {
        contentItem.color = "white"
    }
}
