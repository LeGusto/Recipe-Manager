import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: root
    background: Rectangle {
        color: parent.enabled ? (parent.hovered ? "#b37c11" : "#E9A319") : "#b37c11"
        radius: 20
        border.color: parent.enabled ? "#FAD59A" : "#A86523"
        border.width: 2

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
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
