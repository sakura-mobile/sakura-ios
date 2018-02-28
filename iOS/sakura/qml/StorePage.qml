import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

Item {
    id: storePage

    Image {
        id: imageBackgroundStorePage
        source: "qrc:/resources/images/background_main.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            color: "black"
            opacity: 0.6
            anchors.fill: parent
        }

        Flickable {
            anchors.centerIn: parent
            width: buttonsColumn.width
            height: Math.min(
                        buttonsColumn.height,
                        parent.height - (backButton.height
                                         + backButton.anchors.bottomMargin) * 2 - 8)
            contentWidth: buttonsColumn.width
            contentHeight: buttonsColumn.height
            clip: true

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }

            Column {
                id: buttonsColumn
                spacing: 1
                Image {
                    id: purchase1
                    source: "qrc:/resources/images/rectangle-hi.png"

                    width: 300
                    height: 60

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "5"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/button_quick_tip.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase1
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countQuickTip",
                                                      "") === "") {
                                mainWindow.setSetting("countQuickTip", 5)
                            } else {
                                mainWindow.setSetting("countQuickTip", Number(
                                                          mainWindow.getSetting(
                                                              "countQuickTip",
                                                              "")) + 5)
                            }
                            console.log("countQuickTip :: " + Number(
                                            mainWindow.getSetting(
                                                "countQuickTip", "")))
                        }
                    }
                }

                Image {
                    id: purchase2
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "5"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/lantern_step_ice_booster.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }
                    MouseArea {
                        id: mouseAreaPurchase2
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countBlockStepLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockStepLantern",
                                                      5)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockStepLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockStepLantern",
                                                       "")) + 5)
                            }
                            console.log("countBlockStepLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockStepLantern", "")))
                        }
                    }
                }

                Image {
                    id: purchase3
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "5"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/lantern_time_ice_booster.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase3
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countBlockTimeLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockTimeLantern",
                                                      5)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockTimeLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockTimeLantern",
                                                       "")) + 5)
                            }
                            console.log("countBlockTimeLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockTimeLantern", "")))
                        }
                    }
                }

                Image {
                    id: purchase4
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "20"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/button_quick_tip.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase4
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countQuickTip",
                                                      "") === "") {
                                mainWindow.setSetting("countQuickTip", 20)
                            } else {
                                mainWindow.setSetting("countQuickTip", Number(
                                                          mainWindow.getSetting(
                                                              "countQuickTip",
                                                              "")) + 20)
                            }
                            console.log("countQuickTip :: " + Number(
                                            mainWindow.getSetting(
                                                "countQuickTip", "")))
                        }
                    }
                }

                Image {
                    id: purchase5
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "20"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/lantern_step_ice_booster.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase5
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countBlockStepLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockStepLantern",
                                                      20)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockStepLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockStepLantern",
                                                       "")) + 20)
                            }
                            console.log("countBlockStepLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockStepLantern", "")))
                        }
                    }
                }

                Image {
                    id: purchase6
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "20"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/lantern_time_ice_booster.png"
                        width: 50
                        height: 50
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase6
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countBlockTimeLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockTimeLantern",
                                                      20)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockTimeLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockTimeLantern",
                                                       "")) + 20)
                            }
                            console.log("countBlockTimeLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockTimeLantern", "")))
                        }
                    }
                }

                Image {
                    id: purchase7
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        radius: 20
                        width: 80
                        height: 30
                        border.color: "#C5007F"
                        border.width: 3
                        gradient: Gradient {
                            GradientStop {
                                position: 0.0
                                color: "#C5007F"
                            }
                            GradientStop {
                                position: 1.0
                                color: "purple"
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 10
                            text: "20"
                            font.pointSize: 20
                            font.family: "Helvetica"
                            color: "white"
                        }
                    }
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        source: "qrc:/resources/images/lantern_time_ice_booster.png"
                        width: 50
                        height: 50
                    }
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30

                        source: "qrc:/resources/images/lantern_step_ice_booster.png"
                        width: 50
                        height: 50
                    }
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 45

                        source: "qrc:/resources/images/button_quick_tip.png"
                        width: 35
                        height: 35
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }

                    MouseArea {
                        id: mouseAreaPurchase7
                        anchors.fill: parent
                        onClicked: {
                            if (mainWindow.getSetting("countBlockStepLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockStepLantern",
                                                      20)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockStepLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockStepLantern",
                                                       "")) + 20)
                            }

                            if (mainWindow.getSetting("countBlockTimeLantern",
                                                      "") === "") {
                                mainWindow.setSetting("countBlockTimeLantern",
                                                      20)
                            } else {
                                mainWindow.setSetting(
                                            "countBlockTimeLantern",
                                            Number(mainWindow.getSetting(
                                                       "countBlockTimeLantern",
                                                       "")) + 20)
                            }

                            if (mainWindow.getSetting("countQuickTip",
                                                      "") === "") {
                                mainWindow.setSetting("countQuickTip", 20)
                            } else {
                                mainWindow.setSetting("countQuickTip", Number(
                                                          mainWindow.getSetting(
                                                              "countQuickTip",
                                                              "")) + 20)
                            }
                            console.log("countQuickTip :: " + Number(
                                            mainWindow.getSetting(
                                                "countQuickTip", "")))
                            console.log("countBlockTimeLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockTimeLantern", "")))
                            console.log("countBlockStepLantern :: " + Number(
                                            mainWindow.getSetting(
                                                "countBlockStepLantern", "")))
                        }
                    }
                }

                Image {
                    id: purchase8
                    source: "qrc:/resources/images/rectangle-hi.png"
                    width: 300
                    height: 60

                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 20
                        text: qsTr("Remove Ads")
                        font.pointSize: 16
                        font.family: "Helvetica"
                        font.bold: true
                        color: "white"
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: "qrc:/resources/images/button_store.png"
                        width: 80
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("BUY")
                            color: "white"
                            font.pointSize: 14
                            font.family: "Helvetica"
                        }
                    }
                }
            }
        }

        Image {
            id: backButton
            source: "qrc:/resources/images/back.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
            anchors.left: parent.left
            anchors.leftMargin: 15
            height: 40
            width: 40

            MouseArea {
                id: mouseAreaBackAwardsButton
                anchors.fill: parent
                onClicked: {
                    mainStackView.pop()
                }
            }
        }
    }
}
