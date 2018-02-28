import QtQuick 1.1
import QtWebKit 1.0
import com.nokia.meego 1.0
import QtMobility.feedback 1.1

Page {
    id:              helpPage
    anchors.fill:    parent
    orientationLock: PageOrientation.LockLandscape

    onStatusChanged: {
        if (status === PageStatus.Active) {
            helpWebView.url = "qrc:/resources/doc/help.html";
        }
    }

    function rumbleEffectStart() {
        rumbleEffect.start();
    }

    Flickable {
        id:             helpWebViewFlickable
        anchors.fill:   parent
        contentWidth:   helpWebView.width
        contentHeight:  helpWebView.height

        WebView {
            id:              helpWebView
            preferredWidth:  helpWebViewFlickable.width
            preferredHeight: helpWebViewFlickable.height
        }
    }

    Image {
        id:             backButton
        source:         "../images/back.png"
        anchors.left:   parent.left
        anchors.bottom: parent.bottom
        z:              1

        MouseArea {
            id:           mouseAreaBackButton
            anchors.fill: parent
            onClicked: {
                 rumbleEffectStart();
                 mainPageStack.replace(mainPage);
            }
        }
    }

    HapticsEffect {
         id: rumbleEffect
         attackIntensity: 0.0
         attackTime: 250
         intensity: 1.0
         duration: 250
         fadeTime: 250
         fadeIntensity: 0.0
    }
}
