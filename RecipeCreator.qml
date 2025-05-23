import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0
import AppSettings 1.0

// Used by the user to create new recipes
Page {
    id: recipeCreatorPage
    property string name: ""
    property int time: 0
    property ListModel steps: ListModel {}
    property ListModel ingredients: ListModel {}
    property bool showError: false

    background: Rectangle {
        color: Settings.backgroundColor
    }

    // Structure of each step card
    Component {
        id: stepComponent

        Rectangle {
            id: stepRect
            property int stepNumber
            property string stepText

            width: formLayout.width

            height: rowLayout.implicitHeight + 20
            radius: 8
            color: "white"
            border.color: "#FAD59A"
            border.width: 2

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Label {
                    text: "Step " + stepNumber
                    color: "black"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop
                }

                TextArea {
                    id: stepField
                    color: "black"
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    placeholderText: "Enter step..."

                    // Behavior on Layout.preferredHeight {
                    //     NumberAnimation {
                    //         duration: 200
                    //         easing.type: Easing.OutQuad
                    //     }
                    // }
                    Layout.preferredHeight: Math.max(60, contentHeight + 20)

                    background: Rectangle {
                        radius: 8
                        color: "whitesmoke"
                        border.color: "#cccccc"
                        border.width: 2
                    }

                    onTextChanged: {
                        if (stepNumber - 1 >= 0
                                && stepNumber - 1 < steps.count) {
                            steps.setProperty(stepNumber - 1, "stepText", text)
                        }
                    }
                }
            }

            // Fade in animation
            opacity: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Component.onCompleted: opacity = 1
        }
    }

    // Structure of each ingredient
    Component {
        id: ingredientComponent

        Rectangle {
            width: Math.min(ingredientLabel.implicitWidth + 30,
                            ingredientsFlow.width)
            height: 40
            radius: 15
            color: "#f0f0f0"
            border.color: "#FAD59A"
            border.width: 2
            property string ingredientText: ""
            property int ingredientId: 0

            Label {
                id: ingredientLabel
                anchors.centerIn: parent
                text: ingredientText
                color: "black"
                padding: 5
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            ButtonStyled1 {
                implicitWidth: 26
                implicitHeight: 26
                anchors {
                    right: parent.right
                    top: parent.top
                    margins: -5
                }

                contentItem: Text {
                    text: "X"
                    color: "red"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                flat: true
                onClicked: {
                    for (var i = 0; i < ingredients.count; i++) {
                        if (ingredients.get(i).ingredientId === ingredientId) {
                            ingredients.remove(i)
                            break
                        }
                    }
                }
            }
        }
    }

    // Reusable label for input
    Component {
        id: nameLabelComponent
        Label {
            font.pixelSize: 30
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // Display all the input options
    ScrollView {
        anchors.fill: parent

        anchors.centerIn: parent
        // padding: 20
        padding: 20
        contentWidth: parent.width - padding * 2
        contentHeight: formLayout.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ColumnLayout {
            id: formLayout
            width: Math.min(Settings.maxWidth, parent.width)
            spacing: 15
            anchors.centerIn: parent

            // anchors.horizontalCenter: parent.horizontalCenter
            Loader {
                sourceComponent: nameLabelComponent
                Layout.fillWidth: true
                onLoaded: {
                    item.text = "Name"
                }
            }

            // Name input
            Rectangle {
                // width: parent.width
                Layout.fillWidth: true
                height: 60
                radius: 8
                color: "white"
                border.color: "#FAD59A"
                border.width: 2

                StyledTextField {
                    id: nameField
                    anchors.fill: parent
                    anchors.margins: 10
                    // color: "black"
                    onActiveFocusChanged: if (activeFocus) {
                                              recipeCreatorPage.showError = false
                                              errorLabel.visible = false
                                              errorLabel.text = ""
                                          }

                    hasError: recipeCreatorPage.showError

                    placeholderText: "Recipe name"
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Label {
                id: errorLabel
                color: "red"
                wrapMode: Text.Wrap
                text: ""
                visible: false
                font.pixelSize: 16

                Layout.alignment: Qt.AlignHCenter
            }

            Loader {
                sourceComponent: nameLabelComponent
                Layout.fillWidth: true
                onLoaded: {
                    item.text = "Time to cook"
                }
            }

            // Time to cook input
            Rectangle {
                Layout.fillWidth: true
                height: 60
                radius: 8
                color: "white"
                border.color: "#FAD59A"
                border.width: 2

                RowLayout {
                    anchors.centerIn: parent
                    width: parent.width * 0.9
                    spacing: 10

                    Label {
                        color: "black"
                        text: "Hours:"
                    }
                    SpinBox {
                        id: hoursTime
                        hoverEnabled: true
                        from: 0
                        to: 99
                        value: 0

                        background: Rectangle {
                            border.color: "#FAD59A"
                            border.width: 2
                            color: parent.hovered ? "#3E4143" : "#313435" // Subtle background color change
                            radius: 4

                            Behavior on color {
                                ColorAnimation {
                                    duration: 200 // Animation time in milliseconds
                                    easing.type: Easing.InOutQuad // Smooth easing
                                }
                            }
                        }
                    }
                    Label {
                        color: "black"
                        text: "Minutes:"
                    }
                    SpinBox {
                        id: minutesTime
                        hoverEnabled: true
                        from: 0
                        to: 59
                        value: 0

                        background: Rectangle {
                            border.color: "#FAD59A"
                            border.width: 2
                            color: parent.hovered ? "#3E4143" : "#313435" // Subtle background color change
                            radius: 4

                            Behavior on color {
                                ColorAnimation {
                                    duration: 200 // Animation time in milliseconds
                                    easing.type: Easing.InOutQuad // Smooth easing
                                }
                            }
                        }
                    }
                }
            }

            // List of entered ingredients
            ColumnLayout {
                id: ingredientsColumn
                Layout.fillWidth: true
                spacing: 10
                implicitHeight: ingredientsList.height + 15 // Total padding

                Loader {
                    sourceComponent: nameLabelComponent
                    Layout.fillWidth: true
                    onLoaded: item.text = "Ingredients"
                }

                // Shows all the ingredients in flow-style
                Rectangle {
                    id: ingredientsList
                    Layout.fillWidth: true
                    implicitHeight: Math.max(50, ingredientsFlow.height + 20)
                    radius: 8
                    color: "white"
                    border.color: "#FAD59A"
                    border.width: 2

                    Flow {
                        id: ingredientsFlow
                        width: parent.width - 20

                        anchors {
                            top: parent.top
                            left: parent.left
                            margins: 10
                        }
                        spacing: 8

                        Repeater {
                            model: ingredients
                            delegate: Loader {
                                sourceComponent: ingredientComponent
                                onLoaded: {
                                    item.ingredientText = model.ingredientText
                                    item.ingredientId = model.ingredientId
                                }
                            }
                        }
                    }
                }
                RowLayout {
                    id: ingredientButtons
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter

                    StyledTextField {
                        id: newIngredientInput
                        property int countId: 0

                        onAccepted: {
                            if (text.trim() !== "") {
                                ingredients.append({
                                                       "ingredientText": text.trim(
                                                                             ),
                                                       "ingredientId": countId
                                                   })
                                text = ""
                                countId++
                            }
                        }

                        placeholderText: "Name and quantity"
                    }

                    // Button to add the ingredient that was entered into input
                    ButtonStyled1 {
                        text: "Add"
                        onClicked: newIngredientInput.accepted()
                    }
                }
            }

            // Displays all the steps
            ColumnLayout {
                id: stepsColumn
                Layout.fillWidth: true
                spacing: 10

                Loader {
                    sourceComponent: nameLabelComponent
                    Layout.fillWidth: true
                    onLoaded: {
                        item.text = "Steps"
                    }
                }

                Repeater {
                    model: steps
                    delegate: Loader {
                        sourceComponent: stepComponent
                        property int stepIndex: index
                        onLoaded: {
                            item.stepNumber = index + 1
                            item.stepText = modelData
                        }
                    }
                }
            }

            // Buttons to manage steps (pop most recent step or add one step)
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: Math.min(Settings.maxWidth * 0.6,
                                              parent.width - 40)
                spacing: 10

                ButtonStyled1 {
                    // Layout.alignment: Qt.AlignHCenter
                    text: "+ Add Step"
                    onClicked: steps.append({
                                                "stepText": ""
                                            })
                }

                ButtonStyled1 {
                    // Layout.alignment: Qt.AlignHCenter
                    text: "- Remove Step"
                    onClicked: {
                        if (steps.count > 0) {
                            var lastLoader = null
                            for (var i = stepsColumn.children.length - 1; i >= 0; i--) {
                                if (stepsColumn.children[i] instanceof Loader) {
                                    lastLoader = stepsColumn.children[i]
                                    break
                                }
                            }
                            lastLoader.item.opacity = 0
                            removeTimer.start()
                        }
                    }
                }

                Timer {
                    id: removeTimer
                    interval: 300
                    onTriggered: steps.remove(steps.count - 1)
                }
            }
        }
    }

    // Validate submission input
    function validateInput() {
        for (var i = 0; i < AppCore.dbHandler.recipes.length; i++) {
            if (nameField.text.trim() === "") {
                errorLabel.text = "Name cannot be empty"
                showError = true
                errorLabel.visible = true
                return false
            }

            if (AppCore.dbHandler.recipes[i].Name === nameField.text) {
                errorLabel.text = "Name must be unique"
                showError = true
                errorLabel.visible = true
                return false
            }
        }
        return true
    }

    // Navigation
    footer: RowLayout {
        width: parent.width
        spacing: 0

        // Return to the recipe list without submitting
        NavButton {
            id: backButton
            text: "Back"
            onClicked: stackView.replace("Recipes.qml")
            highlighted: true
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width / 2
        }

        // Submit recipe with the details that were entered
        NavButton {
            id: submitButton
            Layout.alignment: Qt.AlignHCenter
            text: "Save Recipe"
            highlighted: true
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width / 2
            onClicked: {

                if (!validateInput())
                    return

                submitButton.enabled = false
                submitButton.text = "Processing..."

                var ingredientsAdd = []
                var i

                for (i = 0; i < ingredients.count; i++) {
                    ingredientsAdd.push(ingredients.get(i).ingredientText)
                }

                var stepsAdd = []
                for (i = 0; i < steps.count; i++) {
                    stepsAdd.push(steps.get(i).stepText)
                }

                AppCore.dbHandler.addRecipe({
                                                "Name": nameField.text,
                                                "Ingredients": ingredientsAdd,
                                                "Hours": hoursTime.value.toString(
                                                             ),
                                                "Minutes": minutesTime.value.toString(
                                                               ),
                                                "Steps": stepsAdd,
                                                "id": nameField.text
                                            })
            }
        }
    }

    // Switch pages after successfully storing the recipe in the database
    Connections {
        target: AppCore.dbHandler

        function onAddRecipeSuccess() {

            submitButton.enabled = false
            submitButton.text = "Save Recipe"
            stackView.replace("Recipes.qml")
        }
    }
}
