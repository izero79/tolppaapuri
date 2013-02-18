CONFIG  -=forOvi
CONFIG  -=forUnsigned
DEFINES +=DEBUGONLYTOFILE
CONFIG  +=mobility

VERSION = 0.9.0

DEFINES += MAJORVERSION=0
DEFINES += MINORVERSION=9
DEFINES += PATCHVERSION=0

macx|win32{
    folder_01.source = qml/Tolppaapuri_m
    folder_02.source = qml/Tolppaapuri_s
    folder_01.target = qml
    folder_02.target = qml
    DEPLOYMENTFOLDERS += folder_01
    DEPLOYMENTFOLDERS += folder_02
}


DEPLOYMENT.display_name = "Tolppa-apuri"

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian{
    forOvi{
        # For symbian signed app
        # when building signed app, enable define below
        DEFINES += BUILDFORSIGNED

        # UID for ovi store for Lite
        symbian:TARGET.UID3 = 0x20046EA1


    }else{
        !forUnsigned{
            # For symbian signed app
            # when building signed app, enable define below
            DEFINES += BUILDFORSIGNED

            # UID for symbian signed
            symbian:TARGET.UID3 = 0x20046EA1

        }else{
            # For self signed app:
            # UID for self signed
            symbian:TARGET.UID3 =  0xA001615F
        }
    }

    customrules.pkg_prerules = \
            "; Localised Vendor name" \
            "%{\"Tero Siironen\"}" \
            " " \
            "; Unique Vendor name" \
            ":\"Tero Siironen\""

    DEPLOYMENT += customrules


    # Smart Installer package's UID
    # This UID is from the protected range and therefore the package will
    # fail to install if self-signed. By default qmake uses the unprotected
    # range value if unprotected UID is defined for the application and
    # 0x2002CCCF value if protected UID is given to the application
    #symbian:DEPLOYMENT.installer_header = 0x2002CCCF

    # Allow network access on Symbian
    #symbian:TARGET.CAPABILITY += NetworkServices
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
!symbian:CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
symbian:CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    applicationcontroller.cpp \
    qmlwindow.cpp \
    settings.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
!symbian{
OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog
}

HEADERS += \
    applicationcontroller.h \
    qmlwindow.h \
    settings.h

!symbian{
    RESOURCES += resources_m.qrc
}else{
    RESOURCES += resources_s.qrc
}
macx|win32{
    RESOURCES += resources_s.qrc
}

RESOURCES += \
    translations.qrc
