import QtQuick 2.15
import QtQuick.Controls 2.15
import RecipeManager 1.0


Page {
    title: "Recipe Cards"

    ListModel {
        id: recipeModel
    }


    function loadRecipes() {
        for (var i = 0; i < AppCore.dbHandler.recipes.length; i++) {
            var ingredientsTxt = "No ingredients";
            if (AppCore.dbHandler.recipes[i].Ingredients) {
                ingredientsTxt = AppCore.dbHandler.recipes[i].Ingredients.join(", ")
            }

            recipeModel.append({
                name: AppCore.dbHandler.recipes[i].id || "Unnamed Recipe",
                minutes: AppCore.dbHandler.recipes[i].Minutes || "No time",
                hours: AppCore.dbHandler.recipes[i].Hours || " No time",
                ingredientsText: ingredientsTxt,
                recipeId: AppCore.dbHandler.recipes[i].id || "No Id"
            })
        }
    }

    Component.onCompleted: {
        if (AppCore && AppCore.dbHandler) {
            loadRecipes();
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
                        text: "⏱ " + hours + " hours " + minutes + " minutes"
                        font.pixelSize: 14
                        color: "gray"
                    }

                    Text {
                        width: parent.width
                        text: ingredientsText
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

            onClicked: {
                stackView.replace("RecipeCreator.qml");
            }

            return
        }
    }
}
