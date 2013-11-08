#include <QCoreApplication>
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
    QString appName("Tolppa-apuri");
    mView->rootContext()->setContextProperty( "settings", mSettings );
    mView->setSource(QUrl("qrc:/qml/main.qml"));
    mView->show();

    QQuickItem *obj = mView->rootObject();

    QString version( VER );
    obj->setProperty( "versionString", version );
    obj->setProperty( "appName", APPNAME );
    connect(obj,SIGNAL(openUrl(QString)),this,SLOT(openBrowser(QString)));
}

ApplicationController::~ApplicationController()
{
    QMetaObject::invokeMethod(mView->rootObject(), "aboutToQuit");
}

void ApplicationController::quit()
{
    qApp->quit();
}

void ApplicationController::openBrowser( const QString &url )
{
    qDebug() << Q_FUNC_INFO;
    QDesktopServices::openUrl(QUrl(url));
}
