import QtQuick 2.15
import QtQuick.Controls 2.15
import RecipeManager 1.0


Page {
    title: "Recipe Cards"

    ListModel {
        id: recipeModel
    }

    DatabaseHandler {
       id: dbHandler
       onUploadDone: function(response) { console.log("Success:", response) }
       onUploadFail: function(error) { console.log("Error:", error) }

       onRecipesFetched: function(recipes) {
           recipeModel.clear()

           for (var i = 0; i < recipes.length; i++) {
               recipeModel.append({
                   name: recipes[i].id || "Unnamed Recipe",
                   time: recipes[i].Time || "No time",
                   ingredients: recipes[i].Ingredients || "No ingredients",
               })
           }
       }

        Component.onCompleted: fetchRecipes()
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
                        text: "⏱ " + time
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

                Button {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 30
                        text: "×"
                        onClicked: {
                        dbHandler.deleteRecipe(name)
                        recipeModel.remove(index)
                    }
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

            // onClicked: {
            //     stackView.replace("AddRecipe.qml");
            // }

            recipeModel.append({
                name: "New",
                time: "0 mins",
                ingredients: "ingredients"
            })

            dbHandler.putData("Recipes/New", {
                         Ingredients: "ingredients",
                         Time: "0 mins"
                    });
            recipeListView.positionViewAtEnd()
        }
    }
}
