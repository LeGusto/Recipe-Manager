import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0


ApplicationWindow {
    id: window
    width: 400
    height: 500
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: AppCore.authHandler.getIdToken() ? "Recipes.qml" : "Start.qml"
    }

    Connections {
        target: AppCore
        function onAuthenticationChanged() {
            if (AppCore.userSession.hasActiveSession()) {
                stackView.replace("Recipes.qml")
            } else {
                stackView.replace("Login.qml");
            }
        }
    }
}
