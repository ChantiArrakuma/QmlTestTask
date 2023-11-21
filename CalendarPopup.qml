import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id:root

    property var firstDate: []
    property var secondDate: []
    property var curDate: []

    property string dateColor: "#e1d5c9"
    property string inactiveDateColor: "#e1d5c9"
    property string monthBarColor: "green"
    property string backgroundColor: "white"
    property string fontMonthColor: "white"
    property string fontDateColor: "black"

    clip: true

    signal dateSelected(var year, var month, var day)

    background: Rectangle {
        color: backgroundColor
    }

    contentItem: MyCalendar {

        anchors.centerIn: parent

        firstDate: root.firstDate
        secondDate: root.secondDate
        curDate: root.curDate

        dateColor: root.dateColor
        inactiveDateColor: root.inactiveDateColor
        monthBarColor: root.monthBarColor

        fontMonthColor: root.fontMonthColor
        fontDateColor: root.fontDateColor



        onDateClicked: (year, month, day) => {
            dateSelected(year, month, day)
        }
    }
}
