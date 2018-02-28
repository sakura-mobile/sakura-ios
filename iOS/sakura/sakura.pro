QT += quick quickcontrols2 sql
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += src/main.cpp \
    src/uuidcreator.cpp \
    src/gifcreator.mm \
    src/sharehelper.mm \
    src/admobhelper.mm \
    src/storehelper.mm

RESOURCES += qml.qrc \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/uuidcreator.h \
    src/gif.h \
    src/gifcreator.h \
    src/sharehelper.h \
    src/admobhelper.h \
    src/storehelper.h

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
