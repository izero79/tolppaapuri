#ifndef APPLICATIONCONTROLLER_H
#define APPLICATIONCONTROLLER_H

#include <QObject>

class QQuickView;
class Settings;

class ApplicationController : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationController(QQuickView *view);
    ~ApplicationController();

public slots:
    void quit();
    void openBrowser( const QString &url );

private:
    QQuickView *mView;
    Settings *mSettings;

};

#endif // APPLICATIONCONTROLLER_H
