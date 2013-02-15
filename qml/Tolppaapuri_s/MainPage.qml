import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: page
    tools: commonTools
    property string currentTime: ""
    property string startTime: startTimeString()
    property string timeToStart: timeToStartString()
    property int minutesToStartTime: 0
    property int degrees: 360 - parseInt(minutesToStartTime / 4)
    property int commonMargin: 2
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
        height: 90

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
            font.pixelSize: 26
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
            font.pixelSize: 26
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
            font.pixelSize: 26
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
            anchors.topMargin: -5
            minimumValue: 0
            maximumValue: 59
            stepSize: 1
            width: parent.width
            onValueChanged: timeToStartString()
        }
    }

    Image {
        id: clock1frame
        anchors.top: parent.top
        x: appWindow.landscape ? 0 : (parent.width - width) / 2
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
