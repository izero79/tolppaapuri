import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    id: page
    tools: commonTools
    property string currentTime: ""
    property string startTime: startTimeString()
    property string timeToStart: timeToStartString()
    property int currentTimeInMinutes: 0
    property int minutesToStartTime: 0
    property int degrees: 360 - parseInt(minutesToStartTime / 4)
    property int currentTimeDegrees: - (360 - parseInt(currentTimeInMinutes / 4))
    property int commonMargin: 8
    property int clockType: 1
    property int setHour: appWindow.savedHour
    property int setMinute: appWindow.savedMinute

    onCurrentTimeChanged: timeToStartString()

    function setInitHour(savedHour) {
        hoursSlider.value = savedHour
    }

    function setInitMinute(savedMinute) {
        minutesSlider.value = savedMinute
    }

    function setInitClockType(savedType) {
        clockType = savedType
    }

    function startTimeString() {
        page.setHour = hoursSlider.value
        page.setMinute = minutesSlider.value
        appWindow.saveTime(hoursSlider.value, minutesSlider.value)
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
        page.currentTimeInMinutes = parseInt(timeNow.getHours() * 60 + timeNow.getMinutes())
        //console.log("minutes now: " + page.currentTimeInMinutes)
        //console.log("degrees: " + page.currentTimeDegrees)
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
        y: appWindow.landscape ? commonMargin : parent.height / 2
        width: appWindow.landscape ? parent.width / 2 : parent.width
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
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
            text: qsTr("")
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Item {
        id: timeToStartContainer
        anchors.top: labelsContainer.bottom
        width: appWindow.landscape ? parent.width / 2 : parent.width
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
        height: 150

        Label {
            id: hoursToStartHeaderLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
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

        Slider {
            id: hoursSlider
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: hoursToStartLabel.bottom
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
    }

    Image {
        id: clockFrame
        anchors.bottom: parent.bottom
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
        source: clockType == 1 ? "graphics/clock1_frame_white.png" : "graphics/clock2_frame_white.png"
        smooth: true
        rotation: clockType == 1 ? 0 : page.degrees + 30
        Behavior on rotation { PropertyAnimation { duration: 400 } }
    }
    Image {
        id: clockKnob
        x: clockFrame.x + (clockFrame.width - width) / 2
        y: clockFrame.y + (clockFrame.height - height) / 2
        source: clockType == 1 ? "graphics/clock1_knob_white.png" : "graphics/clock2_knob_white.png"
        rotation: clockType == 1 ? page.degrees : page.currentTimeDegrees
        smooth: true
        Behavior on rotation { PropertyAnimation { duration: 400 } }
    }
    Image {
        id: clockMarker
        anchors.bottom: parent.bottom
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
        source: clockType == 1 ? "" : "graphics/clock2_mark_white.png"
        smooth: true
        visible: clockType == 1 ? false : true
    }

}
