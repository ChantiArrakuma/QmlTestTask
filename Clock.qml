import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle {
    id: root

    property string fontColor: "white"
    property string parentBgColor: "white"
    property real clockSpacing: 10
    property real pixelSize: 30

    property int minutes: minutesClock.currentIndex
    property int hours: hoursClock.currentIndex

    color: parentBgColor

    Text {
        text: ":"
        anchors.centerIn: parent
        font.pixelSize: 20
        color: fontColor
    }

    ClockTumbler {
        id: minutesClock
        anchors.right: parent.right
        height: parent.height
        width: parent.width/2-clockSpacing/2
        model: 60
        pixelSize: root.pixelSize
        fontColor: root.fontColor
    }

    ClockTumbler {
        id: hoursClock
        anchors.left: parent.left
        height: parent.height
        width: parent.width/2-clockSpacing/2
        model: 24

        pixelSize: root.pixelSize
        fontColor: root.fontColor
    }
    ClockFade {
        anchors.fill: minutesClock
        delegateHeight: minutesClock.delegateHeight
    }
    ClockFade {
        anchors.fill: hoursClock
        delegateHeight: minutesClock.delegateHeight
    }
}

