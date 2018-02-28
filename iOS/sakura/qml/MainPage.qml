import QtQuick 2.9

Item {
    id:           mainPage
    Rectangle {
        id:           backgroundRectangle
        anchors.fill: parent
        color:        "black"

        Image {
            id:               imageBackgroundMain
            anchors.centerIn: parent
            width:            parent.width
            height:           parent.height
            source:           "qrc:/resources/images/background_app.jpg"
            fillMode:         Image.PreserveAspectCrop

            Rectangle {
                id:               imageInterfMain
                anchors.horizontalCenter: imageBackgroundMain.horizontalCenter
                anchors.verticalCenter: imageBackgroundMain.verticalCenter

                Column {
                    anchors.centerIn: parent
                    spacing:      10

                    Image {
                        id:     buttonTutorial
                        source: "qrc:/resources/images/button.png"
                        width: 240
                        height: 50

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            text:             qsTr("TUTORIAL")
                            font.pointSize:   24
                            font.family: "ChalkboardSE"
                            font.weight: Font.Black
                            color:            "white"
                        }


                        MouseArea {
                            id:           mouseAreaTutorial
                            anchors.fill: parent
                            onClicked: {
                                var component = Qt.createComponent("TutorialPage.qml");

                                if (component.status === Component.Ready) {
                                    mainStackView.push(component);
                                } else {
                                    console.log(component.errorString());
                                }
                            }
                        }
                    }

                    Image {
                        id:     buttonCampania
                        source: "qrc:/resources/images/button.png"
                        width: 240
                        height: 50

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            text:             qsTr("CAMPAIGN")
                            font.pointSize:   24
                            font.family: "ChalkboardSE"
                            font.weight: Font.Black
                            color:            "white"
                        }

                        MouseArea {
                            id:           mouseAreaCampania
                            anchors.fill: parent
                            onClicked: {
                                var component = Qt.createComponent("MapPage.qml");

                                if (component.status === Component.Ready) {
                                    mainStackView.push(component,{currentCampaign:mainWindow.getSetting("maxLevelCampaign", 0), currentLocation:mainWindow.getSetting("maxLevelLocation", 0)});
                                } else {
                                    console.log(component.errorString());
                                }
                            }
                        }
                    }

                    Image {
                        id:     buttonTournament
                        source: "qrc:/resources/images/button.png"
                        width: 240
                        height: 50

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            text:             qsTr("TOURNAMENT")
                            font.pointSize:   24
                            font.family: "ChalkboardSE"
                            font.weight: Font.Black
                            color:            "white"

                        }

                        MouseArea {
                            id:           mouseAreaLevel
                            anchors.fill: parent
                            onClicked: {
                                var component = Qt.createComponent("SingleLevelsPage.qml");

                                if (component.status === Component.Ready) {
                                    mainStackView.push(component);
                                } else {
                                    console.log(component.errorString());
                                }

                                //AdMobHelper.showInterstitial();
                            }
                        }
                    }

                    Image {
                        id:     buttonStore
                        source: "qrc:/resources/images/button.png"
                        width: 240
                        height: 50

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            text:             qsTr("STORE")
                            font.pointSize:   24
                            font.family: "ChalkboardSE"
                            font.weight: Font.Black
                            color:            "white"

                        }


                        MouseArea {
                            id:           mouseAreaHelp
                            anchors.fill: parent
                            onClicked: {
                                var component = Qt.createComponent("StorePage.qml");

                                if (component.status === Component.Ready) {
                                    mainStackView.push(component);
                                } else {
                                    console.log(component.errorString());
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        mainWindow.setSetting("countBlockTimeLantern", 10);
        mainWindow.setSetting("countBlockStepLantern", 10);
        mainWindow.setSetting("countQuickTip", 1000);


        mainWindow.getSetting("userUuid", "");
        if ( mainWindow.getSetting("userUuid", "") === "") {
             mainWindow.setSetting("userUuid", UuidCreator.createUuid());
        }

        if (mainWindow.getSetting("countBlockTimeLantern", "") === "") {
            mainWindow.setSetting("countBlockTimeLantern", 10);
        }

        if (mainWindow.getSetting("countBlockStepLantern", "") === "") {
            mainWindow.setSetting("countBlockStepLantern", 10);
        }

        if (mainWindow.getSetting("countQuickTip", "") === "") {
            mainWindow.setSetting("countQuickTip", 1000);
        }
    }
}
