#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include <QDesktopServices>

#include "applicationcontroller.h"
#include "settings.h"

ApplicationController::ApplicationController(QQuickView *view) :
    mView(view),
    mSettings(new Settings(this))
{
    mView->rootContext()->setContextProperty( "settings", mSettings );
    mView->setSource(QUrl("qrc:/qml/main.qml"));
    mView->show();

    QQuickItem *rootObj = mView->rootObject();

    rootObj->setProperty( "versionString", VER );
    rootObj->setProperty( "appName", APPNAME );
    connect(rootObj,SIGNAL(openUrl(QString)),this,SLOT(openBrowser(QString)));
}

ApplicationController::~ApplicationController()
{
    QMetaObject::invokeMethod(mView->rootObject(), "aboutToQuit");
}

void ApplicationController::openBrowser( const QString &url )
{
    qDebug() << Q_FUNC_INFO;
    QDesktopServices::openUrl(QUrl(url));
}
