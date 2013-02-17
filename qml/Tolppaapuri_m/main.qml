import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage


    property bool landscape: !inPortrait
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
        visible: true
        ToolIcon {
            platformIconId: "toolbar-view-menu"
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
        }
    }

    Component.onCompleted: {
        theme.inverted = true
    }
}
