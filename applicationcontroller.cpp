#include <QTimer>
#include <QCoreApplication>

#include "applicationcontroller.h"
#include "qmlwindow.h"

ApplicationController::ApplicationController(QObject *parent) :
    QObject(parent),
    mQMLWin(0)
{
    initGUI();
    QTimer::singleShot(0, this, SLOT(initObjects()));
}

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

ApplicationController::~ApplicationController()
{
    mQMLWin->setSavedTime();
    mQMLWin->deleteLater();
    mQMLWin = 0;
}

void ApplicationController::quit()
{
    qApp->quit();
}

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
