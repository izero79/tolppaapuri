import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog{
    id: root

    property string text: qsTr( "version " ) + versionString + "\nTero Siironen" + "\nizero79@gmail.com"
    property string iconFileName: "graphics/tolppaapuri96.png"
    property int iconSize: 96

    signal openHomepage()

    focus: true

    Label {
        id: dialogHeader
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Theme.itemSizeLarge
        text: "Tolppa-apuri"
        font.family: Theme.fontFamilyHeading
        font.pixelSize: Theme.fontSizeLarge
    }

    Item {
        id: base
        anchors.top: dialogHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Theme.paddingLarge
        focus: true

        Image {
            id: icon
            visible: iconFileName != ""
            source: iconFileName
            anchors.left: parent.left
            anchors.margins: Theme.paddingMedium
            anchors.top: parent.top
            height: iconSize
            width: iconSize
        }

        Label {
            id: aboutText
            anchors.top: parent.top
            anchors.left: icon.right
            anchors.right: parent.right
            text:  root.text
            smooth: true
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            id: urlText
            anchors.top: aboutText.height >= icon.height ? aboutText.bottom : icon.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.paddingMedium
            text:  "http://www.iki.fi/z7/tolppaapuri"
            smooth: true
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            MouseArea {
                id: urlMouse
                anchors.fill: parent
                onClicked: {
                    root.openHomepage()
                }
            }
        }

    }
}
