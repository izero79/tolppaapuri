#include <QDebug>
#include <QGuiApplication>
#include <QLocale>
#include <QQuickView>
#include <QTranslator>
#include "sailfishapp.h"

#include "applicationcontroller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    QString locale = QLocale::system().name();
    qDebug() << "System locale name" << locale;
    QTranslator translator;

    bool ok = translator.load(QString(":/tolppa-apuri_") + locale);
    qDebug() << "Translator loaded ok" << ok;
    if( !ok ) {
        ok = translator.load(QString(":/tolppa-apuri_en_US"));
    }
    ok = app->installTranslator(&translator);
    qDebug() << "Translator installed ok" << ok;

    QQuickView view(SailfishApp::createView());

    ApplicationController cont(&view);

    return app->exec();
}
