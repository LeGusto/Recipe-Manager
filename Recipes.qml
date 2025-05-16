import QtQuick 2.15
import QtQuick.Controls 2.15
import RecipeManager 1.0

Page {
    title: "Recipe Cards"

    // Contains all the recipes
    ListModel {
        id: recipeModel
    }

    // Converts the recipe steps object received from REST API to a suitable QML object
    function convertSteps(stepsArray) {
        var model = Qt.createQmlObject('import QtQuick 2.15; ListModel {}',
                                       parent)

        if (!stepsArray)
            return model
        stepsArray.forEach(function (step) {
            model.append({
                             "stepText": step
                         })
        })
        return model
    }

    // Gets all the recipes stored in dbHandler
    function loadRecipes() {
        for (var i = 0; i < AppCore.dbHandler.recipes.length; i++) {
            var ingredientsTxt = "No ingredients"
            if (AppCore.dbHandler.recipes[i].Ingredients) {
                ingredientsTxt = AppCore.dbHandler.recipes[i].Ingredients.join(
                            ", ")
            }

            recipeModel.append({
                                   "name": AppCore.dbHandler.recipes[i].id
                                   || "Unnamed Recipe",
                                   "minutes": AppCore.dbHandler.recipes[i].Minutes
                                   || "No time",
                                   "hours": AppCore.dbHandler.recipes[i].Hours
                                   || " No time",
                                   "ingredientsText": ingredientsTxt,
                                   "recipeId"// stepsArray: stepsArray,
                                   : AppCore.dbHandler.recipes[i].id || "No Id",
                                   "steps": convertSteps(
                                                AppCore.dbHandler.recipes[i].Steps)
                               })
        }
    }

    // If everything is in order, loads the recipes into recipeModel
    Component.onCompleted: {
        if (AppCore && AppCore.dbHandler) {
            loadRecipes()
        } else {
            if (!AppCore)
                console.error("AppCore undefined!")
            else
                console.error("dbHandler undefined!")
        }
    }

    // Display the recipe cards
    ListView {
        id: recipeListView
        anchors.fill: parent
        model: recipeModel
        spacing: 10
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        header: Item {
            height: 15
        }

        delegate: Item {
            width: ListView.view.width
            height: 120

            // Rectangle for the background of the info
            Rectangle {
                width: parent.width - 30
                height: parent.height
                radius: 8
                color: "white"
                border.color: "#e0e0e0"
                anchors.horizontalCenter: parent.horizontalCenter

                // Displays some info about the reipe
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

                // Allows you to click the card to view a detailed version of the recipe
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("ViewRecipe.qml", {
                                           "recipe": {
                                               "name": name,
                                               "hours": hours,
                                               "minutes": minutes,
                                               "ingredientsText": ingredientsText,
                                               "steps": steps
                                           }
                                       })
                    }
                }

                // Button for deleting the recipe
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

    // Button for logging out
    header: Button {
        id: logoutBtn
        text: "Log Out"
        highlighted: true

        onClicked: {
            // Disable button during logout process
            logoutBtn.enabled = false
            AppCore.authHandler.logout()
        }
    }

    // Button for adding a new recipe
    footer: Button {
        width: recipeListView.width - 30
        height: 50
        x: (recipeListView.width - width) / 2
        text: "Add New Recipe"
        highlighted: true

        onClicked: {

            onClicked: {
                stackView.replace("RecipeCreator.qml")
            }

            return
        }
    }
}
