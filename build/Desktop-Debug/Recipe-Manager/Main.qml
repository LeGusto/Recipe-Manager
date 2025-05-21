import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0
import AppSettings 1.0

ApplicationWindow {
    id: window
    width: Settings.maxWidth
    height: Settings.maxHeight
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: AppCore.authHandler.getIdToken(
                         ) ? "Recipes.qml" : "Start.qml"
    }

    Connections {
        target: AppCore
        function onAuthenticationChanged() {
            if (AppCore.userSession.hasActiveSession()) {
                AppCore.dbHandler.fetchRecipes()
            } else {
                stackView.replace("Login.qml")
            }
        }
    }

    Connections {
        target: AppCore.dbHandler
        function onFetchRecipesSuccess() {
            stackView.replace("Recipes.qml")
        }

        function onFetchRecipesFail() {
            stackView.replace("Recipes.qml")
        }
    }
}
