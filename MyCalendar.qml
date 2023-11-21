import QtQuick 2.15
import Qt.labs.calendar 1.0
//import QtQuick.Controls 2.15

ListView {
    id: root

    width: 200
    height: 200

    property var firstDate: []
    property var secondDate: []
    property var curDate: []

    property string dateColor: ""
    property string inactiveDateColor: ""
    property string monthBarColor: ""

    property string fontMonthColor: ""
    property string fontDateColor: ""

    orientation: ListView.Horizontal
    highlightRangeMode: ListView.StrictlyEnforceRange

    spacing: 20

    signal dateClicked(var year, var month, var day)

    model: CalendarModel {
        from: new Date(firstDate[0],firstDate[1],firstDate[2])
        to: new Date(secondDate[0],secondDate[1],secondDate[2])
    }

    currentIndex: curDate[1]+12

    delegate: Column {

        property int curMonth: model.month

        Rectangle {
            id: monthPanel

            width: root.width
            height: root.height/10

            radius: 10

            color: monthBarColor

            Text {
                anchors.centerIn: parent

                font.pixelSize: parent.height >= (parent.width)/text.length ? (parent.width-1)/text.length :  parent.height-1

                text: model.month+1 + " " + model.year

                color: fontMonthColor
            }
        }

        MonthGrid {

            width: root.width
            height: root.height-monthPanel.height

            month: model.month
            year: model.year

            delegate: Rectangle {
                radius: 10

                color: model.month === curMonth ? dateColor : inactiveDateColor

                opacity: model.month === curMonth ? 1 : 0.3

                Text {
                    anchors.centerIn: parent

                    font.pixelSize: parent.height >= parent.width ? parent.width-1 :  parent.height-1

                    text: model.day

                    color: fontDateColor
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        dateClicked(model.year, model.month, model.day)
                    }
                }
            }
        }
    }
}
