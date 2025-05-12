import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RecipeManager 1.0

Page {
    id: signupPage
    title: "Sign Up"

    property bool showError: false
    signal signupFailed(string errorMessage)

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8

        StyledTextField {
            Layout.fillWidth: true
            id: nameField
            placeholderText: "Full Name"
            hasError: signupPage.showError && text.trim() === ""
            onActiveFocusChanged: if (activeFocus) {
                signupPage.showError = false
                errorLabel.text = "";
            }


            Layout.alignment: Qt.AlignHCenter
        }

        StyledTextField {
            Layout.fillWidth: true
            id: emailField
            placeholderText: "Email"
            hasError: signupPage.showError && !acceptableInput
            onActiveFocusChanged: if (activeFocus) {
                signupPage.showError = false
                errorLabel.text = "";
            }

            validator: RegularExpressionValidator {
                regularExpression: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
            }

            Layout.alignment: Qt.AlignHCenter
        }

        StyledTextField {
            Layout.fillWidth: true
            id: passwordField
            placeholderText: "Password (min 8 chars)"
            echoMode: TextInput.Password
            hasError: signupPage.showError && text.length < 8
            onActiveFocusChanged: if (activeFocus) {
                signupPage.showError = false
                errorLabel.text = "";
            }


            Layout.alignment: Qt.AlignHCenter
        }

        StyledTextField {
            Layout.fillWidth: true
            id: confirmPasswordField
            placeholderText: "Confirm Password"
            echoMode: TextInput.Password
            hasError: signupPage.showError && (text !== passwordField.text || text === "")
            onActiveFocusChanged: if (activeFocus) {
                signupPage.showError = false
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
                onClicked: stackView.replace("Start.qml")
            }

            Button {
                id: signupButton
                text: "Sign Up"
                highlighted: true

                onClicked: {

                    if (nameField.text.trim() === "") {
                        signupFailed("Please enter your name")
                        return
                    }

                    if (!emailField.acceptableInput) {
                        signupFailed("Please enter a valid email address")
                        return
                    }

                    if (passwordField.text.length < 8) {
                        signupFailed("Password must be at least 8 characters")
                        return
                    }

                    if (passwordField.text !== confirmPasswordField.text) {
                        signupFailed("Passwords don't match")
                        return
                    }

                    signupButton.enabled = false
                    signupButton.text = "Processing..."

                    AppCore.authHandler.signUp(emailField.text, passwordField.text)
                }
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
        function onSignUpFailed(error) {
            signupButton.enabled = true
            signupButton.text = "Sign Up"
            signupFailed(error)
        }

        function onSignUpCompleted() {
            signupButton.enabled = true
            signupButton.text = "Sign Up"
            stackView.replace("Login.qml")
        }
    }

    Connections {
        target: signupPage
        function onSignupFailed(errorMessage) {
            showError = true
            errorLabel.text = errorMessage
        }
    }
}
