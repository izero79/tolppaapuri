#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int savedHour READ savedHour WRITE setHour)
    Q_PROPERTY(int savedMinute READ savedMinute WRITE setMinute)
    Q_PROPERTY(int clockType READ clockType WRITE setClockType)
public:
    explicit Settings(QObject *parent = 0);

signals:
    void savedHourChanged();
    void savedMinuteChanged();
    void clockTypeChanged();

public slots:
    int savedHour() const;
    int savedMinute() const;
    int clockType() const;
    void setHour(int hour);
    void setMinute(int minute);
    void setClockType(int type);
};

#endif // SETTINGS_H
