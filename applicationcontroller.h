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

//    bool eventFilter(QObject *obj, QEvent *event);

public slots:
    void quit();
/*
private slots:
    void initGUI();
    void initObjects();
*/
private:
    QQuickView *mView;
    Settings *mSettings;

};

#endif // APPLICATIONCONTROLLER_H
