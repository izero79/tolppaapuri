import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page
    property string currentTime: ""
    property string startTime: startTimeString()
    property string timeToStart: timeToStartString()
    property int minutesToStartTime: 0
    property int degrees: 360 - parseInt(minutesToStartTime / 4)
    property int commonMargin: 8
    property int clockType: 1

    onCurrentTimeChanged: timeToStartString()

    function startTimeString() {
        if (minutesSlider.value < 10) {
            return hoursSlider.value + ":0" + minutesSlider.value
        } else {
            return hoursSlider.value + ":" + minutesSlider.value
        }
    }

    function timeToStartString() {
        var timeNow = new Date();
        var startDate = new Date();
        startDate.setHours(hoursSlider.value)
        startDate.setMinutes(minutesSlider.value)
        if (startTomorrow() === true) {
            startDate.setDate(startDate.getDate() + 1)
        }
        var toStart = startDate - timeNow
        page.minutesToStartTime = parseInt(toStart / 1000 / 60)
        var hoursToStart = parseInt(toStart / 1000 / 60 / 60)
        var minutesToStart = parseInt((minutesToStartTime) - (hoursToStart * 60))
        if (minutesToStart < 0) {
            hoursToStart = hoursToStart - 1
            minutesToStart = 60 + minutesToStart
        }
        //console.log("minutes to start: " + page.minutesToStartTime)
        //console.log("degrees: " + page.degrees)
        if (minutesToStart<10) {
            return hoursToStart + ":0" + minutesToStart;
        }

        return hoursToStart + ":" + minutesToStart;
    }

    function startTomorrow() {
        var timeNow = new Date();
        var tomorrow = false;
        if (timeNow.getHours() > hoursSlider.value) {
            tomorrow = true;
        } else if (timeNow.getHours() == hoursSlider.value) {
            if (timeNow.getMinutes() >= minutesSlider.value) {
                tomorrow = true;
            }
        }
        return tomorrow;
    }

    Timer {
        id: timeTimer
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            page.currentTime = Qt.formatDateTime(new Date(), "h:mm")
        }
    }

    Item {
        id: labelsContainer
        anchors.top: parent.top
        anchors.topMargin: commonMargin
        width: appWindow.landscape ? parent.width / 2 : parent.width
        x: appWindow.landscape ? 0 : (parent.width - width) / 2
        height: 130

        Label {
            id: currentTimeHeaderLabel
            anchors.top: parent.top
            anchors.topMargin: commonMargin
            anchors.left: parent.left
            anchors.leftMargin: commonMargin
            width: parent.width / 2
            text: qsTr("Current time:")
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: currentTimeLabel
            anchors.top: currentTimeHeaderLabel.bottom
            anchors.topMargin: commonMargin
            anchors.left: parent.left
            anchors.leftMargin: commonMargin
            width: parent.width / 2
            text: currentTime
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
        }

        Label {
            id: startTimeHeaderLabel
            anchors.top: parent.top
            anchors.topMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            width: parent.width / 2
            text: qsTr("Start time:")
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: startTimeLabel
            anchors.top: startTimeHeaderLabel.bottom
            anchors.topMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            width: parent.width / 2
            text: startTime
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: noteLabel
            anchors.top: startTimeLabel.bottom
            anchors.topMargin: commonMargin
            anchors.left: parent.left
            anchors.leftMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            text: qsTr("Nootti")
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Item {
        id: timeToStartContainer
        anchors.top: labelsContainer.bottom
        width: appWindow.landscape ? parent.width / 2 : parent.width
        x: appWindow.landscape ? 0 : (parent.width - width) / 2
        height: 150

        Slider {
            id: hoursSlider
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            minimumValue: 0
            maximumValue: 23
            stepSize: 1
            width: parent.width
            onValueChanged: timeToStartString()
        }

        Slider {
            id: minutesSlider
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: hoursSlider.bottom
            minimumValue: 0
            maximumValue: 59
            stepSize: 1
            width: parent.width
            onValueChanged: timeToStartString()
        }

        Label {
            id: hoursToStartHeaderLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: minutesSlider.bottom
            text: qsTr("Time to start:")
        }
        Label {
            id: hoursToStartLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: hoursToStartHeaderLabel.bottom
            anchors.topMargin: commonMargin
            text: timeToStart
            font.pixelSize: 30
        }

    }

    Image {
        id: clock1frame
        anchors.bottom: parent.bottom
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
        source: "graphics/clock1_frame_white.png"
        smooth: true
        Image {
            id: clock1knob
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            source: "graphics/clock1_knob_white.png"
            rotation: page.degrees
            smooth: true
            Behavior on rotation { PropertyAnimation { duration: 400 } }
        }

    }
}
