import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Item {
        anchors.fill: parent

        TimerElement {
            id: timerElement
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            width: parent.width

            clockType: appWindow.clockType;
            degrees: appWindow.degrees
            degreesWithOffset: appWindow.degreesWithOffset
            currentTimeDegrees: appWindow.currentTimeDegrees
            minutesToStartTime: appWindow.minutesToStartTime
            offsetDiff: appWindow.offsetDiff
            currentTimeInMinutes: appWindow.currentTimeInMinutes

        }

        Label {
            id: coverTitle
            anchors.top: timerElement.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 2*Theme.paddingLarge
            color: Theme.secondaryColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
            text: timerElement.clockType == 1 ? qsTr("Time to start:") : qsTr("Start time:")
        }

        Label {
            id: timeLeftLabel
            anchors.top: coverTitle.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 2*Theme.paddingLarge
            color: Theme.secondaryColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeMedium
            text: timerElement.clockType == 1 ? appWindow.timeToStart : appWindow.startTime
        }
    }
    onStatusChanged: {
        appWindow.coverVisible = (status == Cover.Active)
    }
}
