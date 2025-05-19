import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AppTheme 1.0

Page {
    id: startPage
    title: "Start"
    background: Rectangle {
        color: Theme.backgroundColor
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 100
        width: parent.width * 0.8

        Text {
            text: "Recipe Manager"
            font.pixelSize: 36
            // style: Text.Outline
            // styleColor: "#FCEFCB"
            color: "#FCEFCB"

            Layout.alignment: Qt.AlignHCenter
        }

        // Navigation
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            ButtonStyled1 {
                id: loginButton
                text: "Login"

                onClicked: {
                    stackView.replace("Login.qml")
                }
            }

            ButtonStyled1 {
                id: signupButton
                text: "Sign Up"

                onClicked: {
                    stackView.replace("Signup.qml")
                }
            }
        }
    }
}
