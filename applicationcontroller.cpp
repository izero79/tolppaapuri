#include <QCoreApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>

#include "applicationcontroller.h"
#include "settings.h"

ApplicationController::ApplicationController(QQuickView *view) :
    mView(view),
    mSettings(new Settings(this))
{
    QString majorVersion;
    majorVersion.setNum( MAJORVERSION );
    QString minorVersion;
    minorVersion.setNum( MINORVERSION );
    QString patchVersion;
    patchVersion.setNum( PATCHVERSION );

    QString appName("Tolppa-apuri");
    mView->rootContext()->setContextProperty( "settings", mSettings );
    mView->setSource(QUrl("qrc:/qml/main.qml"));
    mView->show();

    QQuickItem *obj = mView->rootObject();

    QString version( majorVersion + "." + minorVersion + "." + patchVersion );
    obj->setProperty( "versionString", version );
    obj->setProperty( "appName", appName );

}
/*
void ApplicationController::initGUI()
{
    mQMLWin = new QMLWindow();
    connect(mQMLWin,SIGNAL(quit()),this,SLOT(quit()));
    mQMLWin->showFullScreen();
}

void ApplicationController::initObjects()
{
    mQMLWin->init();
}
*/
ApplicationController::~ApplicationController()
{
    QMetaObject::invokeMethod(mView->rootObject(), "aboutToQuit");

//    mView->rootContext()->
//    mQMLWin->setSavedTime();
//    mQMLWin->deleteLater();
//    mQMLWin = 0;
}

void ApplicationController::quit()
{
    qApp->quit();
}
/*
bool ApplicationController::eventFilter(QObject *obj, QEvent *event)
{
    if (event->type() == QEvent::ApplicationDeactivate) {
        // The application deactivation can be handled here
        // send stop timers to qml
        if( mQMLWin )
        {
            mQMLWin->activeStateChanged( false );
        }
        return QObject::eventFilter(obj, event); // The event is handled
    }
    if (event->type() == QEvent::ApplicationActivate) {
        // The application activation can be handled here
        // send start timers to qml
        if( mQMLWin )
        {
            mQMLWin->activeStateChanged( true );
        }
        return QObject::eventFilter(obj, event);
    }
    return QObject::eventFilter(obj, event); // Unhandled events are passed to the base class
}
*/
