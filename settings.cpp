#include <QSettings>
#include <QDebug>

#include "settings.h"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

int Settings::savedHour() const {
    QSettings settings("TeSi", "tolppaapuri");
    int type = settings.value("savedHour", 0).toInt();
    return type;
}

int Settings::savedMinute() const {
    QSettings settings("TeSi", "tolppaapuri");
    int type = settings.value("savedMinute", 0).toInt();
    return type;
}

int Settings::clockType() const {
    QSettings settings("TeSi", "tolppaapuri");
    int type = settings.value("savedType", 1).toInt();
    return type;
}

void Settings::setHour(int hour) {
    qDebug() << Q_FUNC_INFO;
    QSettings settings("TeSi", "tolppaapuri");
    settings.setValue("savedHour", hour);
}

void Settings::setMinute(int minute) {
    qDebug() << Q_FUNC_INFO;
    QSettings settings("TeSi", "tolppaapuri");
    settings.setValue("savedMinute", minute);
}

void Settings::setClockType(int type) {
    qDebug() << Q_FUNC_INFO;
    QSettings settings("TeSi", "tolppaapuri");
    settings.setValue("savedType", type);
}
