#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "loader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    Loader loader;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("loader",&loader);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
