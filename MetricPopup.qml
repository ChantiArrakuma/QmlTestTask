import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id:root

    property var date: []

    property string metricName: ""
    property string svgSource: ""

    property string contentBGColor: "white"
    property string fontColor: "white"


    signal metricValueAdded()

    clip: true

    function openMetric(name, imageSource){
        metricName = name
        svgSource = imageSource
        root.open()
    }

    onClosed: {
        metricName = ""
        svgSource = ""
    }

    contentItem: Rectangle {
        border.width: width/100
        color: contentBGColor

        Column {
            anchors.centerIn: parent

            width: parent.width

            Clock {
                id: clock

                height: 200
                width: 150

                fontColor: root.fontColor
                parentBgColor: contentBGColor

                anchors.horizontalCenter: parent.horizontalCenter
            }


            MetricSlider {
                id: metricSlider
                height: parent.height*0.25
                width: parent.width*0.8

                anchors.horizontalCenter: parent.horizontalCenter

                from: 1
                to: 10
                value: 1
                stepSize: 1

                sliderImplicitSize: width/10

                backgroundSize: 10

                imageSource: svgSource
            }

            Button{
                id: saveMetricButton
                anchors.horizontalCenter: parent.horizontalCenter

                text: qsTr("save")
                font.pixelSize: 20

                contentItem: Text {
                    text: saveMetricButton.text
                    font: saveMetricButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    color: fontColor
                }

                background: Rectangle {
                    radius: width
                    color: parent.pressed ? "white" : "transparent"
                    Behavior on color {ColorAnimation{duration:200}}
                }

                onClicked: {
                    var tableName = "MetricValues"
                    var tableNames = ["name", "value", "year", "month", "day", "hour", "minute"]
                    var time = [clock.hours, clock.minutes]
                    var tableValues = ["'" + metricName + "'", metricSlider.value, curentDate[0], curentDate[1], curentDate[2],time[0], time[1]]
                    dataChanger.inDB(tableName,tableNames,tableValues)
                    metricSlider.value = 1
                    metricValueAdded()
                    root.close()
                }
            }
        }
    }
}
