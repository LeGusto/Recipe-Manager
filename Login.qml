import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0
import AppTheme 1.0

Page {
    id: loginPage
    title: "Login"
    background: Rectangle {
        color: Theme.backgroundColor
    }

    property bool showError: false
    signal loginFailed(string errorMessage)

    ColumnLayout {

        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8

        // Email input
        StyledTextField {
            Layout.fillWidth: true
            id: emailField
            placeholderText: "Email"
            text: "a@a.com"
            hasError: loginPage.showError
            onActiveFocusChanged: if (activeFocus) {
                                      loginPage.showError = false
                                      errorLabel.text = ""
                                  }

            Layout.alignment: Qt.AlignHCenter
        }

        // Password input
        StyledTextField {
            Layout.fillWidth: true
            id: passwordField
            placeholderText: "Password"
            text: "aaaaaaaa"
            echoMode: TextInput.Password
            hasError: loginPage.showError
            onActiveFocusChanged: if (activeFocus) {
                                      loginPage.showError = false
                                      errorLabel.text = ""
                                  }

            Layout.alignment: Qt.AlignHCenter
        }

        // Navigation
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            ButtonStyled1 {
                id: backButton
                text: "Back"

                onClicked: {
                    stackView.replace("Start.qml")
                }

                Layout.alignment: Qt.AlignHCenter
            }

            ButtonStyled1 {
                id: loginButton
                text: "Login"

                onClicked: {
                    onClicked: {
                        loginButton.enabled = false
                        loginButton.text = "Processing..."
                        AppCore.authHandler.signIn(emailField.text,
                                                   passwordField.text)
                    }
                }

                Layout.alignment: Qt.AlignHCenter
            }
        }

        // Label used to display the error if signin fails
        Label {
            id: errorLabel
            color: "red"
            wrapMode: Text.Wrap

            Layout.alignment: Qt.AlignHCenter
        }
    }

    // Handle login error
    Connections {
        target: AppCore.authHandler
        function onSignInFailed(error) {
            showError = true
            errorLabel.text = error
            loginButton.enabled = true
            loginButton.text = "Login"
        }
    }
}
