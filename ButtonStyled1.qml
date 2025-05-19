import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: root
    background: Rectangle {
        color: parent.hovered ? "#b37c11" : "#E9A319"
        radius: 20
        border.color: "#FAD59A"
        border.width: 2

        Behavior on color {
            ColorAnimation {
                duration: 200 // Animation time in milliseconds
                easing.type: Easing.InOutQuad // Smooth easing
            }
        }

        transform: Scale {
            origin.x: root.width / 2
            origin.y: root.height / 2
            xScale: root.down ? 0.95 : root.hovered ? 1.05 : 1.0
            yScale: root.down ? 0.95 : root.hovered ? 1.05 : 1.0
            Behavior on xScale {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on yScale {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }
    font.pixelSize: 16

    Component.onCompleted: {
        contentItem.color = "white"
    }
}
