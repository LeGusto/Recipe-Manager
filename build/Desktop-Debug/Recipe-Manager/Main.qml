import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 400
    height: 500
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "Start.qml"
    }


}
