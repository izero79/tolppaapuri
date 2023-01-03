import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    id: appWindow

    initialPage: mainPage
    allowedOrientations: Orientation.Portrait|Orientation.Landscape|Orientation.LandscapeInverted|Orientation.PortraitInverted

    property string versionString: ""
    property string appName: ""
    property alias startTime: mainPage.startTime
    property alias timeToStart: mainPage.timeToStart
    property alias currentTimeInMinutes: mainPage.currentTimeInMinutes
    property alias minutesToStartTime: mainPage.minutesToStartTime
    property alias degrees: mainPage.degrees
    property alias degreesWithOffset: mainPage.degreesWithOffset
    property alias currentTimeDegrees: mainPage.currentTimeDegrees
    property alias clockType: mainPage.clockType
    property alias offsetDiff: mainPage.offsetDiff

    property bool coverVisible: false
    property bool applicationActive: Qt.application.active

    signal openUrl(string url)

    function aboutToQuit() {
        //console.log("about to quit")
        settings.savedHour = mainPage.setHour
        settings.savedMinute = mainPage.setMinute
    }

    onCoverVisibleChanged: {
        //console.log('onCoverVisibleChanged: ' + coverVisible)
        if (coverVisible) {
            mainPage.currentTime = Qt.formatDateTime(new Date(), "h:mm")
        }
    }

    onApplicationActiveChanged: {
        //console.log('onApplicationActiveChanged: ' + applicationActive)
    }

    MainPage {
        id: mainPage
    }

    Loader {
        id: aboutDialog

        function open()
        {
            source = Qt.resolvedUrl( "AboutDialog.qml" )
            if( item != null )
            {
                pageStack.push(item)
            }
        }

        function close()
        {
            if( item != null )
            {
                item.close()
            }
        }

        function isVisible()
        {
            if( item != null )
            {
                return item.isVisible
            }
            return false
        }

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        source: ""
    }

    Connections {
        target: aboutDialog.item
        onCanceled: {
            aboutDialog.close()
        }
        onOpenHomepage: {
            console.log("open homepage")
            appWindow.openUrl( "http://www.iki.fi/z7/tolppaapuri" )
        }
    }

    cover: Qt.resolvedUrl("SimpleCover.qml")
}
