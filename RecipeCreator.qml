import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0

Page {
    id: recipeCreatorPage
    property string name: ""
    property int time: 0
    property ListModel steps: ListModel {}
    property ListModel ingredients: ListModel {}
    property bool showError: false;

    Component {
        id: stepComponent

        Rectangle {
            property int stepNumber
            property string stepText

            width: recipeCreatorPage.width * 0.9
            height: 100
            radius: 8
            color: "white"
            border.color: "#e0e0e0"

            RowLayout {
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
                    color: "black"
                    background: Rectangle {
                            radius: 8
                            color: "whitesmoke"
                            border.color: "#cccccc"
                            border.width: 2
                    }
                    id: stepField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    wrapMode: Text.Wrap
                    placeholderText: "Enter step..."

                    onTextChanged: {
                        if (stepNumber - 1 >= 0 && stepNumber - 1 < steps.count) {
                            steps.setProperty(stepNumber - 1, "stepText", text)
                        }
                    }
                }
            }

            Connections {
                target: stepComponent

            }
        }
    }

    Component {
        id: ingredientComponent

        Rectangle {
            width: Math.min(ingredientLabel.implicitWidth + 30, ingredientsFlow.width)
            height: 40
            radius: 15
            color: "#f0f0f0"
            border.color: "#cccccc"
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

            Button {
                implicitWidth: 30
                implicitHeight: 30
                anchors {
                    right: parent.right
                    top: parent.top
                    margins: -5
                }


                contentItem: Text {
                    text: "x"
                    color: "red"
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                flat: true
                onClicked: {
                    for (var i = 0; i < ingredients.count; i++) {
                        if (ingredients.get(i).ingredientId === ingredientId) {
                            ingredients.remove(i);
                            break;
                        }
                    }
                }
            }
        }
    }

    Component {
        id: nameLabelComponent
        Label {
            font.pixelSize: 30
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    ScrollView {
        anchors.fill: parent
        padding: 20
        contentWidth: parent.width * 0.9
        contentHeight: formLayout.height

        ColumnLayout {
            id: formLayout
            width: parent.width
            spacing: 15

            Loader {
                sourceComponent: nameLabelComponent
                Layout.fillWidth: true
                onLoaded: {
                    item.text = "Name"
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                radius: 8
                color: "white"
                border.color: "#e0e0e0"

                StyledTextField {
                        id: nameField
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "black"

                        // background: Rectangle {
                        //     radius: 6
                        //     color: "whitesmoke"
                        //     border.color: "#cccccc"
                        //     border.width: 2
                        // }

                        onActiveFocusChanged: if (activeFocus) {
                            recipeCreatorPage.showError = false
                            errorLabel.text = "";
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
                text: "";

                Layout.alignment: Qt.AlignHCenter
            }

            Loader {
                sourceComponent: nameLabelComponent
                Layout.fillWidth: true
                onLoaded: {
                    item.text = "Time to cook"
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 60
                radius: 8
                color: "white"
                border.color: "#e0e0e0"

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
                        from: 0
                        to: 999
                        value: 0
                    }
                    Label {
                        color: "black"
                        text: "Minutes:"
                    }
                    SpinBox {
                        id: minutesTime
                        from: 0
                        to: 999
                        value: 0
                    }
                }
            }

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

                Rectangle {
                    id: ingredientsList
                    Layout.fillWidth: true
                    implicitHeight: Math.max(50, ingredientsFlow.height + 20)
                    radius: 8
                    color: "white"
                    border.color: "#e0e0e0"

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

                    TextField {
                        id: newIngredientInput
                        property int countId: 0

                        onAccepted: {
                            if (text.trim() !== "") {
                                ingredients.append({
                                    "ingredientText": text.trim(),
                                    "ingredientId": countId
                                });
                                text = "";
                                countId++;
                            }
                        }
                    }

                    Button {
                        text: "Add"
                        onClicked: newIngredientInput.accepted()
                    }
                }
            }

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

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                width: parent.width * 0.9
                spacing: 10

                Button {
                    Layout.alignment: Qt.AlignHCenter
                    text: "+ Add Step"
                    onClicked: steps.append({"stepText": ""})
                }

                Button {
                    Layout.alignment: Qt.AlignHCenter
                    text: "- Remove Step"
                    onClicked: {
                        if (steps.count > 0) steps.remove(steps.count - 1)
                    }
                }
            }
        }
    }

    function validateInput() {
        for (var i = 0; i < AppCore.dbHandler.recipes.length; i++) {
            if (nameField.text.trim() === "") {
                errorLabel.text = "Name cannot be empty"
                showError = true
                return false;
            }

            if (AppCore.dbHandler.recipes[i].Name === nameField.text) {
                errorLabel.text = "Name must be unique"
                showError = true
                return false;
            }
        }
        return true;
    }

    footer: Button {
        Layout.alignment: Qt.AlignHCenter
        text: "Save Recipe"
        highlighted: true
        onClicked: {

            if (!validateInput()) return

            var ingredientsAdd = [];
            var i;

            for (i = 0; i < ingredients.count; i++) {
                ingredientsAdd.push(ingredients.get(i).ingredientText);
            }

            var stepsAdd = [];
            for (i = 0; i < steps.count; i++) {
                stepsAdd.push(steps.get(i).stepText);
            }

            AppCore.dbHandler.addRecipe({
                         Name: nameField.text,
                         Ingredients: ingredientsAdd,
                         Hours: hoursTime.value.toString(),
                         Minutes: minutesTime.value.toString(),
                         Steps: stepsAdd
                    });
        }
    }

}
