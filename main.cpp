#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <databasehandler.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DatabaseHandler>("RecipeManager", 1, 0, "DatabaseHandler");


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Recipe-Manager", "Main");

    return app.exec();
}
