import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.calendar 1.0
import QtGraphicalEffects 1.0

Row {
    id: root

    spacing: 2

    property var curDate: []
    property string mainColor: "#1622a6"
    property real dateFontPixelSize: 10

    signal arrowClick(var newDate)
    signal middleSectionClicked()

    Button {
        height: parent.height
        width: height

        contentItem: Image{
            source: "./svg/leftArrow.svg"
            height: parent.height
            width: height
            sourceSize.width: parent.width*10
            sourceSize.height: parent.height*10

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: mainColor
            }
        }

        background: Rectangle {
            radius: width
            color: parent.pressed ? "white" : "transparent"
            Behavior on color {ColorAnimation{duration:200}}
        }

        onClicked: {
            var date = new Date(curDate[0], curDate[1], curDate[2] - 1)
            var dateVar = [date.getFullYear(), date.getMonth(), date.getDate()]
            arrowClick(dateVar)
        }
    }

    Button {
        id: dateButton

        height: parent.height

        text: curDate[2] + " " + Number(curDate[1] + 1) + " " + curDate[0]
        font.pixelSize: dateFontPixelSize

        contentItem: Text {

            text: dateButton.text
            font: dateButton.font
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            color: mainColor
        }

        background: Rectangle {
            radius: width
            color: parent.pressed ? "white" : "transparent"
            Behavior on color {ColorAnimation{duration:200}}
        }

        onClicked: {
            root.middleSectionClicked()
        }
    }

    Button {
        height: parent.height
        width: height

        contentItem: Image{
            source: "./svg/rightArrow.svg"

            height: parent.height
            width: height
            sourceSize.width: parent.width*10
            sourceSize.height: parent.height*10

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: mainColor
            }
        }

        background: Rectangle {
            radius: width
            color: parent.pressed ? "white" : "transparent"
            Behavior on color {ColorAnimation{duration:200}}
        }
        onClicked: {
            var date = new Date(curDate[0], curDate[1], curDate[2] + 1)
            var dateVar = [date.getFullYear(), date.getMonth(), date.getDate()]
            arrowClick(dateVar)
        }
    }

}
