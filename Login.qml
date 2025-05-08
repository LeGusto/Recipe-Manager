import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: loginPage
    title: "Login"


    ColumnLayout {

        anchors.centerIn: parent
        spacing: 20
        width: parent.width

        TextField {
            id: emailField
            placeholderText: "someone@gmail.com"
            Layout.alignment: Qt.AlignHCenter
        }
        TextField {
            id: passwordField
            placeholderText: "password"
            echoMode: TextInput.Password
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
                    stackView.replace("Recipes.qml");
                }


                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
