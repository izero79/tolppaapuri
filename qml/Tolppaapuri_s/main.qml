import QtQuick 1.1
import com.nokia.symbian 1.1

PageStackWindow {
    id: appWindow

    initialPage: mainPage
    showStatusBar: true
    showToolBar: true
    property bool landscape: !inPortrait
    property int savedHour: 0
    property int savedMinute: 0

    signal saveTime(int hour, int minute)
    signal quit()

    onSavedHourChanged: mainPage.setInitHour(savedHour)
    onSavedMinuteChanged: mainPage.setInitMinute(savedMinute)

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
                }
            }
        }
    }
}
