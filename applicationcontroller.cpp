#include <QTimer>
#include <QCoreApplication>
#include <QDebug>

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
    qDebug() << "taalla";
    mQMLWin->init();
}

ApplicationController::~ApplicationController()
{
    mQMLWin->deleteLater();
    mQMLWin = 0;
}

void ApplicationController::quit()
{
    qApp->quit();
}
