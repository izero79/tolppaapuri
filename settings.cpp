#include <QSettings>

#include "settings.h"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

int Settings::savedHour() const {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    int type = settings.value("savedHour", 0).toInt();
    return type;
}

int Settings::savedMinute() const {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    int type = settings.value("savedMinute", 0).toInt();
    return type;
}

int Settings::clockType() const {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    int type = settings.value("savedType", 1).toInt();
    return type;
}

void Settings::setHour(int hour) {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    settings.setValue("savedHour", hour);
}

void Settings::setMinute(int minute) {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    settings.setValue("savedMinute", minute);
}

void Settings::setClockType(int type) {
    QSettings settings("fi.iki.z7", "tolppaapuri");
    settings.setValue("savedType", type);
}
