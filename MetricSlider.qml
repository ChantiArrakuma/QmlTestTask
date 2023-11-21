import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: root

    snapMode: "SnapOnRelease"

    orientation: "Horizontal"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                               implicitHandleHeight + topPadding + bottomPadding)

    from: 1
    to: 10
    stepSize: 1


    property int sliderImplicitSize: 15
    property string imageSource: ""
    property int colorScale: 255/((to-from+1)/stepSize)
    property real backgroundSize: 1

    handle: Rectangle {
        id: handleId

        x: root.leftPadding + (root.horizontal ? root.visualPosition * (root.availableWidth - width) : (root.availableWidth - width) / 2)
        y: root.topPadding + (root.vertical ? root.visualPosition * (root.availableHeight - height) : (root.availableHeight - height) / 2)

        implicitWidth: sliderImplicitSize
        implicitHeight: sliderImplicitSize

        radius: width/2
        clip: true

        border.width: root.pressed ? width/2 : 1
        border.color: "white"

        Behavior on border.width { SmoothedAnimation {} }

        Image {
            source: imageSource

            height: root.pressed ? 0 : parent.height
            width: root.pressed ? 0 : parent.width

            sourceSize.height: 100
            sourceSize.width: 100

            anchors.centerIn: parent

            Behavior on width{ SmoothedAnimation {} }
            Behavior on height{ SmoothedAnimation {} }
        }

    }

    background: Rectangle
    {
        id: backgroundId
        x: (root.width  - width) / 2
        y: (root.height - height) / 2

        implicitWidth: root.horizontal ? 200 : backgroundSize
        implicitHeight: root.horizontal ? backgroundSize : 200

        width: root.horizontal ? root.availableWidth : implicitWidth
        height: root.horizontal ? implicitHeight : root.availableHeight

        radius: width
    }

    onValueChanged: {

        var r = 5+value*colorScale
        var g = 280-value*colorScale
        var b = 255
        var a = 1

        handleId.color.r = r
        handleId.color.g = g
        handleId.color.b = b
        handleId.color.a = a

        backgroundId.color.r = r
        backgroundId.color.g = g
        backgroundId.color.b = b
        backgroundId.color.a = a
    }
}
