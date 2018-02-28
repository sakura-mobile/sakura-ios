QT += quick quickcontrols2 sql
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += src/main.cpp \
    src/uuidcreator.cpp

OBJECTIVE_SOURCES += \
    src/gifcreator.mm \
    src/sharehelper.mm \
    src/admobhelper.mm \
    src/storehelper.mm

HEADERS += \
    src/uuidcreator.h \
    src/gif.h \
    src/gifcreator.h \
    src/sharehelper.h \
    src/admobhelper.h \
    src/storehelper.h

RESOURCES += qml.qrc \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

ios {
    LIBS += -F $$PWD/admob -framework GoogleMobileAds \
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

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
