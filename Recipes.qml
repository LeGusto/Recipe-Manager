import QtQuick 2.15
import QtQuick.Controls 2.15
import RecipeManager 1.0
import AppTheme 1.0

Page {
    title: "Recipe Cards"
    background: Rectangle {
        color: Theme.backgroundColor
    }

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

    function convertIngredients(ingredientsArray) {
        var model = Qt.createQmlObject('import QtQuick 2.15; ListModel {}',
                                       parent)
        if (!ingredientsArray)
            return model
        ingredientsArray.forEach(function (step) {
            model.append({
                             "ingredientText": step
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
                                                AppCore.dbHandler.recipes[i].Steps),
                                   "ingredients": convertIngredients(
                                                      AppCore.dbHandler.recipes[i].Ingredients)
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
            property bool beingRemoved: false
            id: delegateItem
            // Rectangle for the background of the info
            Rectangle {
                width: parent.width - 30
                height: parent.height
                radius: 8
                color: recipeMouseArea.containsMouse ? "#c1c1c1" : "white"
                // border.color: "#e0e0e0"
                border.color: "#FAD59A"
                border.width: 2
                anchors.horizontalCenter: parent.horizontalCenter

                // Animations for properties
                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }
                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }

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
                        text: "⏱ " + hours + " hour" + (hours != 1 ? "s " : " ")
                              + minutes + " minute" + (minutes != 1 ? "s " : " ")
                        font.pixelSize: 14
                        color: "gray"
                    }

                    Text {
                        maximumLineCount: 2
                        elide: Text.ElideRight
                        width: parent.width
                        text: ingredientsText
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                    }
                }

                // Allows you to click the card to view a detailed version of the recipe
                MouseArea {
                    id: recipeMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        stackView.push("ViewRecipe.qml", {
                                           "recipe": {
                                               "name": name,
                                               "hours": hours,
                                               "minutes": minutes,
                                               "ingredients": ingredients,
                                               "ingredientsText": ingredientsText,
                                               "steps": steps
                                           }
                                       })
                    }
                }

                // Button for deleting the recipe
                ButtonStyled1 {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: 30
                    text: "×"
                    font.pixelSize: 20
                    onClicked: {
                        beingRemoved = true
                        removeTimer.start()
                    }
                }
            }

            // Timer to remove after animation completes
            Timer {
                id: removeTimer
                interval: 300
                onTriggered: {
                    AppCore.dbHandler.deleteRecipe(name)
                    recipeModel.remove(index)
                }
            }

            // Animate other cards when this one is being removed
            states: State {
                when: beingRemoved
                PropertyChanges {
                    target: delegateItem
                    opacity: 0
                }
                PropertyChanges {
                    target: delegateItem
                    height: 0
                }
            }

            transitions: Transition {
                NumberAnimation {
                    properties: "opacity,height"
                    duration: 300
                }
            }
        }

        footer: Item {
            height: 15
        }
    }

    // Button for logging out
    header: NavButton {
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
    footer: NavButton {
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
