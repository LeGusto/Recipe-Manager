import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0
import AppSettings 1.0

Page {
    id: loginPage
    title: "Login"
    background: Rectangle {
        color: Settings.backgroundColor
    }

    property bool showError: false
    signal loginFailed(string errorMessage)

    ColumnLayout {

        width: Math.min(Settings.maxWidth, parent.width * 0.8)

        anchors.centerIn: parent
        spacing: 20

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
                        backButton.enabled = false
                        // loginButton.text = "Processing..."
                        AppCore.authHandler.signIn(emailField.text,
                                                   passwordField.text)
                    }
                }

                Layout.alignment: Qt.AlignHCenter
            }
        }

        // Label used to display the error if login fails
        Label {
            id: errorLabel
            color: "red"
            wrapMode: Text.Wrap
            font.pixelSize: 16

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
            backButton.enabled = true
            loginButton.text = "Login"
        }
    }
}
