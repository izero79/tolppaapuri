TARGET = tolppaapuri

CONFIG += sailfishapp

DEFINES +=DEBUGONLYTOFILE

VERSION = 1.0.0

DEFINES += MAJORVERSION=1
DEFINES += MINORVERSION=0
DEFINES += PATCHVERSION=0

unix|macx|win32{
    folder_01.source = qml
    folder_01.target = qml
    DEPLOYMENTFOLDERS += folder_01
}


DEPLOYMENT.display_name = "Tolppa-apuri"

OTHER_FILES += qml/*.qml \
    rpm/tolppaapuri.yaml \
    rpm/tolppaapuri.spec \
    tolppaapuri.desktop



# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += tolppaapuri.cpp \
    applicationcontroller.cpp \
    settings.cpp

HEADERS += applicationcontroller.h \
    settings.h


RESOURCES += \
    translations.qrc \
    resources.qrc
