#ifndef APPLICATIONCONTROLLER_H
#define APPLICATIONCONTROLLER_H

#include <QObject>

class QMLWindow;

class ApplicationController : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationController(QObject *parent = 0);
    ~ApplicationController();

    bool eventFilter(QObject *obj, QEvent *event);

public slots:
    void quit();

private slots:
    void initGUI();
    void initObjects();

private:
    QMLWindow *mQMLWin;

};

#endif // APPLICATIONCONTROLLER_H
