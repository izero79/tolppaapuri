TARGET = harbour-tolppaapuri

CONFIG += sailfishapp

DEFINES +=DEBUGONLYTOFILE

VERSION = 1.0.0

VERSTR = '\\"$${VERSION}\\"'
DEFINES += VER=\"$${VERSTR}\"

DEPLOYMENT.display_name = "Tolppa-apuri"
APPNAMESTR = '\\"$${DEPLOYMENT.display_name}\\"'
DEFINES += APPNAME=\"$${APPNAMESTR}\"

OTHER_FILES += qml/*.qml \
    rpm/harbour-tolppaapuri.yaml \
    rpm/harbour-tolppaapuri.spec \
    harbour-tolppaapuri.desktop

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += tolppaapuri.cpp \
    applicationcontroller.cpp \
    settings.cpp

HEADERS += applicationcontroller.h \
    settings.h

    86icon.files = harbour-tolppaapuri.png
    86icon.path = /usr/share/icons/hicolor/86x86/apps/
INSTALLS += 86icon

RESOURCES += \
    translations.qrc \
    resources.qrc
