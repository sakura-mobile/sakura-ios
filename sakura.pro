TEMPLATE = app
TARGET = sakura

QT += quick quickcontrols2 sql multimedia purchasing
CONFIG += c++17 resources_big

DEFINES += QT_DEPRECATED_WARNINGS QT_NO_CAST_FROM_ASCII QT_NO_CAST_TO_ASCII

INCLUDEPATH += 3rdparty

SOURCES += \
    src/contextguard.cpp \
    src/gifcreator.cpp \
    src/main.cpp \
    src/uuidcreator.cpp

OBJECTIVE_SOURCES += \
    src/admobhelper.mm \
    src/audiohelper.mm \
    src/reachabilityhelper.mm \
    src/sharehelper.mm \
    src/storehelper.mm

HEADERS += \
    3rdparty/gif-h/gif.h \
    src/admobhelper.h \
    src/audiohelper.h \
    src/contextguard.h \
    src/gifcreator.h \
    src/reachabilityhelper.h \
    src/sharehelper.h \
    src/storehelper.h \
    src/uuidcreator.h

RESOURCES += \
    qml.qrc \
    resources.qrc \
    translations.qrc

TRANSLATIONS += \
    translations/sakura_de.ts \
    translations/sakura_es.ts \
    translations/sakura_fr.ts \
    translations/sakura_it.ts \
    translations/sakura_ja.ts \
    translations/sakura_ko.ts \
    translations/sakura_ru.ts \
    translations/sakura_zh.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

ios {
    CONFIG += qtquickcompiler

    INCLUDEPATH += ios/frameworks
    DEPENDPATH += ios/frameworks

    LIBS += -F $$PWD/ios/frameworks \
            -framework GoogleAppMeasurement \
            -framework GoogleMobileAds \
            -framework GoogleUtilities \
            -framework nanopb \
            -framework Foundation \
            -framework AVFoundation \
            -framework UIKit \
            -framework StoreKit

    QMAKE_LFLAGS += -ObjC

    QMAKE_APPLE_DEVICE_ARCHS = arm64
    QMAKE_INFO_PLIST = ios/Info.plist
}
