import QtQuick 2.15
import QtQuick.Controls 2.15

Page {

    title: "Recipe Cards"

    // Sample recipe data
    ListModel {
        id: recipeModel
        ListElement {
            name: "Pasta Carbonara"
            prepTime: "15 mins"
            ingredients: "Spaghetti, eggs, pancetta, cheese"
        }
        ListElement {
            name: "Vegetable Stir Fry"
            prepTime: "20 mins"
            ingredients: "Broccoli, carrots, bell peppers, soy sauce"
        }
        // Add more recipes as needed
    }

    Flickable {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: 10
            padding: 15

            // Generate cards using Repeater
            Repeater {
                model: recipeModel

                Rectangle {
                    width: parent.width - 30
                    height: 120
                    radius: 8
                    color: "white"
                    border.color: "#e0e0e0"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 5

                        Text {
                            text: name
                            font.bold: true
                            font.pixelSize: 18
                        }

                        Text {
                            text: "⏱ " + prepTime
                            font.pixelSize: 14
                            color: "gray"
                        }

                        Text {
                            width: parent.width
                            text: "🍴 " + ingredients
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Make it clickable
                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Selected:", name)
                    }
                }
            }
        }
    }
}
