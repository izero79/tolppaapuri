#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QPair>

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = 0);
    static QPair<int,int> savedTime();
    static void saveTime(int hours, int minutes);
    static int savedType();
    static void saveType(int type);

signals:
    
public slots:
    
};

#endif // SETTINGS_H
