#include <QtGui/QApplication>
#include <QLocale>
#include <QTranslator>
#include <QDebug>

#include "applicationcontroller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString locale = QLocale::system().name();

    QTranslator translator;
    bool ok = translator.load(QString(":/tolppaapuri_") + locale);
    if( !ok ) {
        ok = translator.load(QString(":/tolppaapuri_en_US"));
    }
    app.installTranslator(&translator);
    ApplicationController cont;

    return app.exec();

}
