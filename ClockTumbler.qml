import QtQuick 2.15
import QtQuick.Controls 2.15

Tumbler {
    height: parent.height
    width: parent.width

    property real delegateHeight: 0
    property string fontColor: "white"
    property real pixelSize: 10

    delegate: Item {
        id: delegate

        Text {
            text: index
            anchors.centerIn: parent
            color: fontColor
            font.pixelSize: pixelSize
        }

        Component.onCompleted: delegateHeight = delegate.height

        scale: Tumbler.isCurrentItem ? 1 : 0.9
        Behavior on scale { NumberAnimation { duration: 200 } }

        MouseArea {
            anchors.fill: parent
            onClicked: currentIndex = index
        }
    }
}
