import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Item {
        anchors.fill: parent

        Image {
            id: image
            y: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.4
            source: "graphics/tolppaapuri.png"
        }

        Label {
            id: label
            anchors.centerIn: parent
            width: parent.width - 2*Theme.paddingLarge
            color: Theme.secondaryColor
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeSmall
            text: appWindow.appName
        }
    }
}
