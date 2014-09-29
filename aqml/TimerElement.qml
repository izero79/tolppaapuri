import QtQuick 2.0

Item {
    property int clockType: 1;
    property int degrees: 360 - parseInt(minutesToStartTime / 4)
    property int degreesWithOffset: 360 - parseInt((minutesToStartTime-offsetDiff) / 4)
    property int currentTimeDegrees: - (360 - parseInt((currentTimeInMinutes+offsetDiff) / 4))
    property int minutesToStartTime: 0
    property int offsetDiff: 0
    property int currentTimeInMinutes: 0
    height: width

    Image {
        id: clockFrame
        anchors.centerIn: parent
        source: clockType == 1 ? "graphics/clock1_frame_white.png" : "graphics/clock2_frame_white.png"
        smooth: true
        rotation: clockType == 1 ? 0 : degreesWithOffset + 30
        Behavior on rotation { PropertyAnimation { duration: 400 } }
        width: parent.width
        height: width
    }
    Image {
        id: clockKnob
        anchors.centerIn: parent
        source: clockType == 1 ? "graphics/clock1_knob_white.png" : "graphics/clock2_knob_white.png"
        rotation: clockType == 1 ? degrees : currentTimeDegrees
        smooth: true
        Behavior on rotation { PropertyAnimation { duration: 400 } }
        width: parent.width
        height: width
    }
    Image {
        id: clockMarker
        anchors.centerIn: parent
        source: clockType == 1 ? "" : "graphics/clock2_mark_white.png"
        smooth: true
        visible: clockType == 1 ? false : true
        width: parent.width
        height: width
    }
}
