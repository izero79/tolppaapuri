import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage


    property bool landscape: width > height

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
                }
            }
        }
    }

    Component.onCompleted: {
        theme.inverted = true
    }
}
