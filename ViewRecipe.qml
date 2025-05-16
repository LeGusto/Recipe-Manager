import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

// Used for a detailed inspection of a recipe (when you click on a recipe card)
Page {
    id: viewRecipePage
    property var recipe: ({})

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width

        ColumnLayout {
            width: parent.width

            // Padding at the top
            Item {
                height: 15
            }

            // Background for the info
            Rectangle {
                width: parent.width * 0.9
                radius: 8
                color: "white"
                border.color: "#e0e0e0"
                Layout.alignment: Qt.AlignHCenter
                height: itemsLayout.implicitHeight + 20

                // Displays all the actual info
                ColumnLayout {
                    id: itemsLayout
                    width: parent.width
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 5

                    // Recipe name
                    Text {
                        text: recipe.name
                        font.bold: true
                        font.pixelSize: 18
                        Layout.alignment: Qt.AlignHCenter
                    }

                    // Time to cook
                    Text {
                        text: "⏱ " + recipe.hours + " hours " + recipe.minutes + " minutes"
                        font.pixelSize: 14
                        color: "gray"
                    }

                    // Ingredients
                    Text {
                        Layout.fillWidth: true
                        text: recipe.ingredientsText
                        font.pixelSize: 14

                        wrapMode: Text.WordWrap
                    }

                    // Displays all the steps
                    Repeater {
                        model: recipe.steps
                        delegate: ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 5

                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true

                                Rectangle {
                                    width: 25
                                    height: 25
                                    radius: 12.5
                                    color: "#6200ee"

                                    Label {
                                        text: index + 1
                                        color: "white"
                                        anchors.centerIn: parent
                                    }
                                }
                                Label {
                                    text: modelData
                                    color: "black"
                                    wrapMode: Text.Wrap
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    footer: Button {
        text: "Back"
        highlighted: true
        onClicked: stackView.replace("Recipes.qml")
    }
}
