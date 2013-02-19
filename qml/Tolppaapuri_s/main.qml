import QtQuick 1.1
import com.nokia.symbian 1.1

PageStackWindow {
    id: appWindow

    initialPage: mainPage
    showStatusBar: true
    showToolBar: true
    property string versionString: "0.0.0"
    property bool landscape: !inPortrait
    property bool appInBackground: false
    property int savedHour: 0
    property int savedMinute: 0
    property int savedType: 1

    signal saveTime(int hour, int minute)
    signal saveClockType(int type)
    signal quit()

    onSavedHourChanged: mainPage.setInitHour(savedHour)
    onSavedMinuteChanged: mainPage.setInitMinute(savedMinute)
    onSavedTypeChanged: mainPage.setInitClockType(savedMinute)

    function aboutToQuit() {
        appWindow.saveTime(mainPage.setHour, mainPage.setMinute)
        appWindow.quit()
    }

    MainPage {
        id: mainPage
        tools: commonTools
    }

    ToolBarLayout {
        id: commonTools
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: appWindow.pageStack.depth <= 1 ? appWindow.aboutToQuit() : appWindow.pageStack.pop()
        }
        ToolButton {
            iconSource: "toolbar-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("Toggle clock type")
                onClicked: {
                    if (mainPage.clockType == 1) {
                        mainPage.clockType = 2
                    } else
                    {
                        mainPage.clockType = 1
                    }
                    appWindow.saveClockType(mainPage.clockType)
                }
            }
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    aboutDialog.open()
                }
            }
        }
    }

    Loader {
        id: aboutDialog

        function open()
        {
            source = Qt.resolvedUrl( "AboutDialog.qml" )
            if( item != null )
            {
                item.screenX = -x
                item.screenY = -y
                item.open()
            }
        }

        function close()
        {
            if( item != null )
            {
                item.close()
            }
            source = ""
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
        width: appWindow.inPortrait ? mainPage.width : mainPage.width / 5 * 3
        height: appWindow.inPortrait ? mainPage.height / 5 * 2 : mainPage.height / 5 * 4
        source: ""
        z: 100
        onYChanged: {
            if( item != null )
            {
                item.screenX = -x
                item.screenY = -y
            }
        }
    }

    Connections {
        target: aboutDialog.item
        onButton1Clicked: {
            aboutDialog.close()
        }
        onCanceled: {
            aboutDialog.close()
        }
        onOpenHomepage: {
            appWindow.openUrl( "http://www.iki.fi/z7/tolppaapuri" )
        }
    }
}
