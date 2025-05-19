#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <appcore.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterSingletonType<AppCore>("RecipeManager", 1, 0, "AppCore",
                                      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject* {
                                          return new AppCore();
                                      });

    qmlRegisterSingletonType(QUrl::fromLocalFile(QCoreApplication::applicationDirPath()
                                                 + "/Recipe-Manager/Theme.qml"),
                             "AppTheme",
                             1,
                             0,
                             "Theme");

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
