#include <QSettings>
#include <QStringList>
#include <QDebug>

#include "settings.h"

Settings::Settings(QObject *parent) :
    QObject(parent)
{
}

QPair<int,int> Settings::savedTime()
{
    QSettings settings("TeSi", "tolppaapuri");
    int hour = settings.value("savedHour", 0).toInt();
    int minute = settings.value("savedMinute", 0).toInt();
    QPair<int,int> time;
    time.first = hour;
    time.second = minute;
    return time;
}

void Settings::saveTime(int hours, int minutes)
{
    qDebug() << "savet" << hours << minutes;
    QSettings settings("TeSi", "tolppaapuri");
    settings.setValue("savedHour", hours);
    settings.setValue("savedMinute", minutes);
}

int Settings::savedType()
{
    QSettings settings("TeSi", "tolppaapuri");
    int type = settings.value("savedType", 1).toInt();
    return type;
}

void Settings::saveType(int type)
{
    qDebug() << "save" << type;
    QSettings settings("TeSi", "tolppaapuri");
    settings.setValue("savedType", type);
}
