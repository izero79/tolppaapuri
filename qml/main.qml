import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    id: appWindow

    initialPage: mainPage


    property string versionString: "0.0.0"
    property bool landscape: false
    property bool appInBackground: false
    property int savedHour: 0
    property int savedMinute: 0
    property int savedType: 1

    signal saveTime(int hour, int minute)
    signal saveClockType(int type)
    signal quit()
    signal openUrl(string url)

    onSavedHourChanged: mainPage.setInitHour(savedHour)
    onSavedMinuteChanged: mainPage.setInitMinute(savedMinute)
    onSavedTypeChanged: mainPage.setInitClockType(savedMinute)

    function aboutToQuit() {
        console.log("about to quit")
        settings.savedHour = mainPage.setHour
        settings.savedMinute = mainPage.setMinute
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
            //source = ""
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
        width: appWindow.inPortrait ? parent.width / 3 * 2: parent.width / 5 * 2
        height: appWindow.inPortrait ? parent.height / 6 * 2 : parent.height / 5 * 3
        source: ""
        z: 100
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
}