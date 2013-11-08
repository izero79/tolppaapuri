#include <QGuiApplication>
#include <QQuickView>
#include <QtQml>
#include <QLocale>
#include <QTranslator>
#include "sailfishapp.h"

#include "applicationcontroller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QQuickView view(SailfishApp::createView());

    ApplicationController cont(&view);

    QString locale = QLocale::system().name();
    qDebug() << "system locale name" << locale;
    QTranslator translator;

    bool ok = translator.load(QString(":/tolppa-apuri_") + locale);
    qDebug() << "translator load ok" << ok;
    if( !ok ) {
        ok = translator.load(QString(":/tolppa-apuri_en_US"));
    }
    ok = app->installTranslator(&translator);
    qDebug() << "translator install ok" << ok;

    return app->exec();
}
