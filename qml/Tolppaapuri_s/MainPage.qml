import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: page
    tools: commonTools
    property string currentTime: ""
    property string startTime: startTimeString()
    property string timeToStart: timeToStartString()
    property int currentTimeInMinutes: 0
    property int minutesToStartTime: 0
    property int degrees: 360 - parseInt(minutesToStartTime / 4)
    property int degreesWithOffset: 360 - parseInt((minutesToStartTime-offsetDiff) / 4)
    property int currentTimeDegrees: - (360 - parseInt((currentTimeInMinutes+offsetDiff) / 4))
    property int commonMargin: 2
    property int clockType: 1
    property int setHour: appWindow.savedHour
    property int setMinute: appWindow.savedMinute
    property bool dstChange: false
    property int offsetDiff: 0

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
        /*
        // for testing
        startDate.setMonth(9)
        startDate.setDate(26)
        timeNow.setMonth(9)
        timeNow.setDate(26)
        */
        //console.log("time now: " + timeNow)
        if (startTomorrow() === true) {
            startDate.setDate(startDate.getDate() + 1)
        }
        //console.log("start time: " + startDate)
        var offsetNow = timeNow.getTimezoneOffset()
        var offsetStart = startDate.getTimezoneOffset()
        //console.log("offsetNow: " + offsetNow + ", offsetStart: " + offsetStart)
        offsetDiff = offsetStart - offsetNow
        if (offsetDiff != 0) {
            dstChange = true
        } else {
            dstChange = false
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
        running: !appWindow.appInBackground
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
            font.pixelSize: 24
        }

        Label {
            id: hoursToStartHeaderLabel
            anchors.top: parent.top
            anchors.topMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            width: parent.width / 2
            text: qsTr("Time to start:")
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            id: hoursToStartLabel
            anchors.top: hoursToStartHeaderLabel.bottom
            anchors.topMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            width: parent.width / 2
            text: timeToStart
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }

        Label {
            id: noteLabel
            anchors.top: hoursToStartLabel.bottom
            anchors.topMargin: commonMargin
            anchors.left: parent.left
            anchors.leftMargin: commonMargin
            anchors.right: parent.right
            anchors.rightMargin: commonMargin
            text: qsTr("DST change taken into account")
            horizontalAlignment: Text.AlignHCenter
            visible: dstChange
        }
    }

    Item {
        id: timeToStartContainer
        anchors.top: labelsContainer.bottom
        width: appWindow.landscape ? parent.width / 2 : parent.width
        x: appWindow.landscape ? parent.width / 2 : (parent.width - width) / 2
        height: 150

        Label {
            id: startTimeHeaderLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            text: qsTr("Start time:")
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: startTimeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: startTimeHeaderLabel.bottom
            anchors.topMargin: commonMargin
            text: startTime
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        Slider {
            id: hoursSlider
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: startTimeLabel.bottom
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

    Item {
        anchors.top: parent.top
        x: appWindow.landscape ? 0 : (parent.width - width) / 2
        width: appWindow.landscape ? parent.width / 2 : parent.width
        height: appWindow.landscape ? parent.height : parent.height / 2

        Image {
            id: clockFrame
            anchors.centerIn: parent
            source: clockType == 1 ? "graphics/clock1_frame_white.png" : "graphics/clock2_frame_white.png"
            smooth: true
            rotation: clockType == 1 ? 0 : page.degreesWithOffset + 30
            Behavior on rotation { PropertyAnimation { duration: 400 } }
        }
        Image {
            id: clockKnob
            anchors.centerIn: parent
            source: clockType == 1 ? "graphics/clock1_knob_white.png" : "graphics/clock2_knob_white.png"
            rotation: clockType == 1 ? page.degrees : page.currentTimeDegrees
            smooth: true
            Behavior on rotation { PropertyAnimation { duration: 400 } }
        }
        Image {
            id: clockMarker
            anchors.centerIn: parent
            source: clockType == 1 ? "" : "graphics/clock2_mark_white.png"
            smooth: true
            visible: clockType == 1 ? false : true
        }
    }

}
