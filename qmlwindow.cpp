#include <QApplication>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include <QDesktopWidget>
#include <QGraphicsObject>
#include <QDesktopServices>

#include "qmlwindow.h"
#include "settings.h"

QMLWindow::QMLWindow(QWidget *parent) :
    QDeclarativeView(parent),
    mRootContext(0),
    mRootObject(0),
    mHours(0),
    mMinutes(0)
{
    setResizeMode(QDeclarativeView::SizeRootObjectToView);
    mRootContext = rootContext();

#if defined(Q_OS_SYMBIAN)
    setSource(QUrl("qrc:qml/Tolppaapuri_s/main.qml"));
    mRootObject = dynamic_cast<QObject*>(rootObject());
#else
    setSource(QUrl("qrc:qml/Tolppaapuri_m/main.qml"));
    mRootObject = dynamic_cast<QObject*>(rootObject());
#endif
}

QMLWindow::~QMLWindow()
{
}

void QMLWindow::init()
{
    QString majorVersion;
    majorVersion.setNum( MAJORVERSION );
    QString minorVersion;
    minorVersion.setNum( MINORVERSION );
    QString patchVersion;
    patchVersion.setNum( PATCHVERSION );
    QString version( majorVersion + "." + minorVersion + "." + patchVersion );
    mRootObject->setProperty( "versionString", version );

    connect(mRootObject,SIGNAL(quit()),this,SIGNAL(quit()));
    connect(mRootObject,SIGNAL(saveTime(int,int)),this,SLOT(saveTime(int,int)));
    connect(mRootObject,SIGNAL(saveClockType(int)),this,SLOT(saveClockType(int)));
    connect(mRootObject,SIGNAL(openUrl(QString)),this,SLOT(openBrowser(QString)));

    QPair<int,int> savedTime = Settings::savedTime();
    mRootObject->setProperty("savedHour", savedTime.first);
    mRootObject->setProperty("savedMinute", savedTime.second);

    int savedType = Settings::savedType();
    mRootObject->setProperty("savedType", savedType);
}

void QMLWindow::saveTime(int hours, int minutes) {
    mHours = hours;
    mMinutes = minutes;
}

void QMLWindow::setSavedTime() {
    Settings::saveTime(mHours, mMinutes);
}

void QMLWindow::saveClockType(int type) {
    Settings::saveType(type);
}

void QMLWindow::activeStateChanged(bool active) {
    mRootObject->setProperty("appInBackground", !active);
}

void QMLWindow::openBrowser( const QString &url )
{
    QDesktopServices::openUrl(QUrl(url));
}
