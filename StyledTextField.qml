import QtQuick 2.15
import QtQuick.Controls 2.15

// Text field that changes border color based on whether there is an error
TextField {
    id: root
    property bool hasError: false
    hoverEnabled: true

    background: Rectangle {
        border.color: {
            if (root.hasError) {
                return "#ff4444" // Error state (highest priority)
            } else if (root.activeFocus) {
                return "#FFC107" // Focus state
            } else if (root.hovered) {
                return "#FFC107" // Hover state (gold color)
            }
            return "#FAD59A" // Default state
        }
        border.width: 2
        radius: 4
        // color: "transparent"
        color: root.hovered ? "#3E4143" : "#313435" // Subtle background color change

        Behavior on color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
        Behavior on border.color {
            ColorAnimation {
                duration: 200
            }
        }

        transform: Scale {
            origin.x: root.width / 2
            origin.y: root.height / 2
            xScale: root.activeFocus ? 1.02 : 1.0
            yScale: root.activeFocus ? 1.02 : 1.0
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

    color: "white"
}
