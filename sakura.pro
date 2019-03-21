TEMPLATE = app
TARGET = sakura

QT += quick quickcontrols2 sql multimedia purchasing
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += src/main.cpp \
    src/gifcreator.cpp \
    src/uuidcreator.cpp

OBJECTIVE_SOURCES += \
    src/sakuraapplicationdelegate.mm \
    src/sharehelper.mm \
    src/admobhelper.mm \
    src/fbhelper.mm \
    src/storehelper.mm \
    src/audiohelper.mm \
    src/reachabilityhelper.mm

HEADERS += \
    src/sakuraapplicationdelegate.h \
    src/uuidcreator.h \
    src/gif.h \
    src/gifcreator.h \
    src/sharehelper.h \
    src/admobhelper.h \
    src/fbhelper.h \
    src/storehelper.h \
    src/audiohelper.h \
    src/reachabilityhelper.h

RESOURCES += \
    qml.qrc \
    resources.qrc \
    translations.qrc

TRANSLATIONS += \
    translations/sakura_ru.ts \
    translations/sakura_de.ts \
    translations/sakura_fr.ts \
    translations/sakura_it.ts \
    translations/sakura_es.ts \
    translations/sakura_zh.ts \
    translations/sakura_ja.ts \
    translations/sakura_ko.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

ios {
    CONFIG += qtquickcompiler

    INCLUDEPATH += $$PWD/ios/frameworks
    DEPENDPATH += $$PWD/ios/frameworks

    LIBS += -F $$PWD/ios/frameworks \
            -framework GoogleMobileAds \
            -framework Bolts \
            -framework FBSDKCoreKit \
            -framework FBSDKLoginKit \
            -framework FBSDKShareKit \
            -framework AdSupport \
            -framework AVFoundation \
            -framework CFNetwork \
            -framework CoreMedia \
            -framework CoreMotion \
            -framework CoreTelephony \
            -framework CoreVideo \
            -framework GLKit \
            -framework MediaPlayer \
            -framework MessageUI \
            -framework StoreKit \
            -framework SystemConfiguration

    QMAKE_APPLE_DEVICE_ARCHS = arm64
    QMAKE_INFO_PLIST = ios/Info.plist
}
