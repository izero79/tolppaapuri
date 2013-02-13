import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page
    tools: commonTools
    property string currentTime: ""
    property string startTime: startTimeString()
    property string timeToStart: timeToStartString()
    property int minutesToStartTime: 0
    property int degrees: (minutesToStartTime / 4).toFixed()

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
//        console.log("tostart: " + toStart)
        page.minutesToStartTime = (toStart / 1000 / 60).toFixed()
        var hoursToStart = (toStart / 1000 / 60 / 60).toFixed()
        var minutesToStart = ((toStart / 1000 / 60) - (hoursToStart * 60)).toFixed()
        if (minutesToStart < 0) {
            hoursToStart = hoursToStart - 1
            minutesToStart = 60 + minutesToStart
        }
        console.log("minutes to start: " + page.minutesToStartTime)
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

    Label {
        id: currentTimeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        text: qsTr("Current time: " + currentTime)
    }

    Label {
        id: startTimeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: currentTimeLabel.bottom
        text: qsTr("Start time: " + startTime)
    }

    Label {
        id: noteLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: startTimeLabel.bottom
        text: qsTr("")
    }

    Slider {
        id: hoursSlider
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: noteLabel.bottom
        minimumValue: 0
        maximumValue: 23
        stepSize: 1
        onValueChanged: timeToStartString()
    }

    Slider {
        id: minutesSlider
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: hoursSlider.bottom
        minimumValue: 0
        maximumValue: 59
        stepSize: 1
        onValueChanged: timeToStartString()
    }

    Label {
        id: hoursToStartLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: minutesSlider.bottom
        text: qsTr("Time to start: " + timeToStart)
    }

}
