import QtQuick 2.15
import QtGraphicalEffects 1.0

ListView {
    id: root

    orientation: ListView.Horizontal

    property int delegateRotation: 0
    property string logoColor: "white"

    model: myMetricModel

    interactive: false
    spacing: 5

    signal delegateClicked(var MetricName, var SvgSource)

    delegate: Rectangle {

        height: ListView.view.height
        width: ListView.view.height

        scale: delegateMouseArea.pressed ? 1.1 : 1

        rotation: delegateRotation

        radius: width

        color: Color

        Behavior on scale {SmoothedAnimation{duration: 100}}

        Image {

            height: parent.height
            width: parent.width
            sourceSize.width: parent.width*10
            sourceSize.height: parent.height*10

            source: SvgSource

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: logoColor
            }

            MouseArea {
                id: delegateMouseArea
                anchors.fill: parent
                onClicked: {
                    root.delegateClicked(MetricName, SvgSource)
                }
            }
        }
    }
}

