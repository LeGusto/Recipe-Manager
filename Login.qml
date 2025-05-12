import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0

// DISABLE LOGIN BUTTON AFTER PRESSING IT UNTIL RESPONSE RECEIVED

Page {
    id: loginPage
    title: "Login"

    property bool showError: false;
    signal loginFailed(string errorMessage)



    ColumnLayout {

        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8

        StyledTextField {
            Layout.fillWidth: true
            id: emailField
            placeholderText: "Email"
            hasError: loginPage.showError
            onActiveFocusChanged: if (activeFocus) {
                loginPage.showError = false
                errorLabel.text = ""
            }


            Layout.alignment: Qt.AlignHCenter
        }
        StyledTextField {
            Layout.fillWidth: true
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            hasError: loginPage.showError
            onActiveFocusChanged: if (activeFocus) {
                loginPage.showError = false
                errorLabel.text = ""
            }

            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Button {
                id: backButton
                text: "Back"

                onClicked: {
                    stackView.replace("Start.qml");
                }

                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                id: loginButton
                text: "Login"

                onClicked: {
                    onClicked: AppCore.authHandler.signIn(emailField.text, passwordField.text)
                }


                Layout.alignment: Qt.AlignHCenter
            }
        }

        Label {
            id: errorLabel
            color: "red"
            wrapMode: Text.Wrap

            Layout.alignment: Qt.AlignHCenter
        }
    }

    Connections {
        target: AppCore.authHandler
        function onSignInFailed(error) {
            showError = true
            errorLabel.text = error
        }
    }
}
