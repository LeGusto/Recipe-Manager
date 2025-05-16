import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: startPage
    title: "Start"

    // Navigation
    RowLayout {
        anchors.centerIn: parent
        spacing: 20

        Button {
            id: loginButton
            text: "Login"

            onClicked: {
                stackView.replace("Login.qml")
            }
        }

        Button {
            id: signupButton
            text: "Sign Up"

            onClicked: {
                stackView.replace("Signup.qml")
            }
        }
    }
}
