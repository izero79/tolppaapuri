#include <QtGui/QApplication>
#include <QLocale>
#include <QTranslator>

#include "applicationcontroller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString locale = QLocale::system().name();

    QTranslator translator;
    bool ok = translator.load(QString(":/tolppa-apuri_") + locale);
    if( !ok ) {
        ok = translator.load(QString(":/tolppa-apuri_en_US"));
    }
    app.installTranslator(&translator);
    ApplicationController cont;

    app.installEventFilter(&cont); // Installing the event filter

    return app.exec();

}
