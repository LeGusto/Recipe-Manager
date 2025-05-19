import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AppTheme 1.0

// Used for a detailed inspection of a recipe (when you click on a recipe card)
Page {
    id: viewRecipePage
    property var recipe: ({})
    background: Rectangle {
        color: Theme.backgroundColor
    }

    ScrollView {
        anchors.fill: parent
        padding: 20
        contentWidth: parent.width * 0.9
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            width: parent.width

            // Padding at the top
            Item {
                height: 15
            }

            // Background for the info
            Rectangle {
                width: parent.width
                radius: 8
                color: "white"
                border.color: "#FAD59A"
                border.width: 2
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
                        font.pixelSize: 30
                        Layout.alignment: Qt.AlignHCenter
                    }

                    // Time to cook
                    Label {
                        text: "⏱ " + recipe.hours + " hour" + (recipe.hours != 1 ? "s " : " ")
                              + recipe.minutes + " minute" + (recipe.minutes != 1 ? "s " : " ")
                        font.pixelSize: 14
                        color: "gray"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        color: "black"
                        height: 5
                    }

                    Label {
                        text: "Ingredients"
                        color: "black"
                        font.pixelSize: 24
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // Display all the ingredients
                    Repeater {
                        model: recipe.ingredients
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
                                    color: "black"

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

                    Rectangle {
                        Layout.fillWidth: true
                        color: "black"
                        height: 5
                    }

                    Label {
                        text: "Steps"
                        color: "black"
                        font.pixelSize: 24
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
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
                                    Layout.alignment: Qt.AlignTop
                                    width: 25
                                    height: 25
                                    radius: 12.5
                                    color: "black"

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

    footer: NavButton {
        text: "Back"
        highlighted: true
        onClicked: stackView.replace("Recipes.qml")
    }
}
