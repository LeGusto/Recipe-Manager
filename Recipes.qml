import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    title: "Recipe Cards"

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
    }

    ListView {
        id: recipeListView
        anchors.fill: parent
        model: recipeModel
        spacing: 10
        clip: true
        boundsBehavior: Flickable.StopAtBounds


        header: Item { height: 15 }

        delegate: Item {
            width: ListView.view.width
            height: 120

            Rectangle {
                width: parent.width - 30
                height: parent.height
                radius: 8
                color: "white"
                border.color: "#e0e0e0"
                anchors.horizontalCenter: parent.horizontalCenter


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

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Selected:", name)
                }

            }
        }
    }

    footer: Button {
        width: recipeListView.width - 30
        height: 50
        x: (recipeListView.width - width) / 2

        text: "Add New Recipe"
        onClicked: {
            recipeModel.append({
                name: "New Recipe",
                prepTime: "0 mins",
                ingredients: "ingredients"
            })
            recipeListView.positionViewAtEnd()
        }
    }
}
