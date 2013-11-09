TARGET = tolppaapuri

CONFIG += sailfishapp

DEFINES +=DEBUGONLYTOFILE

VERSION = 1.0.0

VERSTR = '\\"$${VERSION}\\"'
DEFINES += VER=\"$${VERSTR}\"

DEPLOYMENT.display_name = "Tolppa-apuri"
APPNAMESTR = '\\"$${DEPLOYMENT.display_name}\\"'
DEFINES += APPNAME=\"$${APPNAMESTR}\"

OTHER_FILES += qml/*.qml \
    rpm/tolppaapuri.yaml \
    rpm/tolppaapuri.spec \
    tolppaapuri.desktop \
    qml/SimpleCover.qml

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += tolppaapuri.cpp \
    applicationcontroller.cpp \
    settings.cpp

HEADERS += applicationcontroller.h \
    settings.h

RESOURCES += \
    translations.qrc \
    resources.qrc
