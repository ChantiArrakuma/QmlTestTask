import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Test task")

    property var curentDate: {
        var newDate = new Date()
        setDate([newDate.getFullYear(), newDate.getMonth(), newDate.getDate()])
    }

    function setDate(yearMonthDay) {
        curentDate = [yearMonthDay[0],yearMonthDay[1],yearMonthDay[2]]
        dateChanger.curDate = [yearMonthDay[0],yearMonthDay[1],yearMonthDay[2]]
        diary.diaryUpdate(curentDate[0],curentDate[1],curentDate[2])
        metricChart.updateChart()
    }

    Rectangle {
        id: mainWindowBg

        anchors.fill: parent

        color: "#e5ecff"

        DateChanger {
            id: dateChanger

            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            curDate: curentDate

            height: 60
            dateFontPixelSize: 20

            onArrowClick: (newDate) => setDate(newDate)
            onMiddleSectionClicked: calendarPopup.open()

            mainColor: "#1622a6"

        }

        CalendarPopup {
            id: calendarPopup

            implicitHeight: parent.height*0.8
            implicitWidth: parent.width*0.8
            anchors.centerIn: parent

            firstDate: [curentDate[0]-1, 0, 1]
            secondDate: [curentDate[0]+1, 11, 31]
            curDate: curentDate

            dateColor: mainWindowBg.color
            monthBarColor: "#427897"

            onDateSelected: (year, month, day) => {
                setDate([year, month, day])
                calendarPopup.close()
            }
        }

        Diary {
            id: diary

            height: parent.height - dateChanger.height - metricList.height
            width: parent.width * 0.4 - 20 + horizontalSpacing - 20

            anchors.left: parent.left
            anchors.leftMargin: 20

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            delegateSpacing: 10
            backgroundRadius: 10

            curDate: curentDate

            backgroundColor: "#cbd9ed"
            addButtonSVGColor: "#1622a6"
        }

        MetricPopup {
            id: metricPopup

            anchors.centerIn: parent

            height: parent.height*0.8
            width: parent.width*0.8

            date: curentDate
            onMetricValueAdded: metricChart.updateChart()

            contentBGColor: mainWindowBg.color

            fontColor: "#1622a6"
        }

        MetricChart {
            id: metricChart

            height: diary.height
            width: parent.width - diary.width - diary.horizontalSpacing * 2

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: diary.horizontalSpacing

            curDate: curentDate
        }

        MetricList {
            id: metricList

            height: parent.height/12
            width: metricChart.width - diary.horizontalSpacing * 8

            rotation: 180
            delegateRotation: 180

            anchors.bottom: metricChart.top
            anchors.right: metricChart.right
            anchors.bottomMargin: -20

            logoColor: parent.color

            onDelegateClicked: (MetricName, SvgSource) => {
                metricPopup.openMetric(MetricName, SvgSource)
            }
        }
    }
}
