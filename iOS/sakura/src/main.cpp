#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include "uuidcreator.h"
#include "sharehelper.h"
#include "gifcreator.h"
#include "admobhelper.h"
#include "storehelper.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    engine.rootContext()->setContextProperty(QStringLiteral("StoreHelper"), new StoreHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("AdMobHelper"), new AdMobHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("ShareHelper"), new ShareHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("GIFCreator"), new GIFCreator(&app));

    engine.rootContext()->setContextProperty(QStringLiteral("UuidCreator"), new UuidCreator(&app));
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));    

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
