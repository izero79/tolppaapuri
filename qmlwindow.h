#ifndef QMLWINDOW_H
#define QMLWINDOW_H

#include <QDeclarativeView>

class QMLWindow : public QDeclarativeView
{
    Q_OBJECT
public:
    explicit QMLWindow(QWidget *parent = 0);
    ~QMLWindow();

public slots:
    void init();
    void setSavedTime();
    void activeStateChanged(bool active);

private slots:
    void saveTime(int hours, int minutes);
    void saveClockType(int type);
    void openBrowser( const QString &url );

signals:
    void quit();

private:
    QDeclarativeContext *mRootContext;
    QObject *mRootObject;
    int mHours;
    int mMinutes;

};

#endif // QMLWINDOW_H
