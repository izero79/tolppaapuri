#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
#if !defined(Q_OS_SYMBIAN)
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/Tolppaapuri_m/main.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/Tolppaapuri_s/main.qml"));
#endif

    viewer.showExpanded();

    return app->exec();
}
