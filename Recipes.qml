import QtQuick 2.15
import QtQuick.Controls 2.15
import RecipeManager 1.0


Page {
    title: "Recipe Cards"

    ListModel {
        id: recipeModel
    }

    Connections {
        target: AppCore.dbHandler

        function onRecipesFetched(recipes) {
            recipeModel.clear()
            for (var i = 0; i < recipes.length; i++) {
                recipeModel.append({
                    name: recipes[i].id || "Unnamed Recipe",
                    time: recipes[i].Time || "No time",
                    ingredients: recipes[i].Ingredients || "No ingredients",
                    recipeId: recipes[i].id
                })
            }
        }
    }

    Component.onCompleted: {
        if (AppCore && AppCore.dbHandler) {
            AppCore.dbHandler.fetchRecipes()
        } else {
            if (!AppCore) console.error("AppCore undefined!")
            else console.error("dbHandler undefined!")
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
                        AppCore.dbHandler.deleteRecipe(name)
                        recipeModel.remove(index)
                    }
                }
            }
        }
    }

    header: Button {
        id: logoutBtn
        text: "Log Out"
        highlighted: true

        onClicked: {
            // Disable button during logout process
            logoutBtn.enabled = false;
            AppCore.authHandler.logout();
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

            AppCore.dbHandler.addRecipe({
                         Ingredients: "ingredients",
                         Time: "0 mins"
                    });
            recipeListView.positionViewAtEnd()
        }
    }
}
