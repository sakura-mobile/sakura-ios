#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>

#include "sakuraapplicationdelegate.h"
#include "admobhelper.h"
#include "fbhelper.h"
#include "sharehelper.h"
#include "storehelper.h"
#include "audiohelper.h"
#include "reachabilityhelper.h"
#include "gifcreator.h"
#include "uuidcreator.h"

int main(int argc, char *argv[])
{
    QTranslator     translator;
    QGuiApplication app(argc, argv);

    if (translator.load(QString(":/tr/sakura_%1").arg(QLocale::system().name()))) {
        QGuiApplication::installTranslator(&translator);
    }

    InitializeSakuraApplicationDelegate();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(QStringLiteral("AdMobHelper"), new AdMobHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("FBHelper"), new FBHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("ShareHelper"), new ShareHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("StoreHelper"), new StoreHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("AudioHelper"), new AudioHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("ReachabilityHelper"), new ReachabilityHelper(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("GIFCreator"), new GIFCreator(&app));
    engine.rootContext()->setContextProperty(QStringLiteral("UuidCreator"), new UuidCreator(&app));

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return QGuiApplication::exec();
}
