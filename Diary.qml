import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Item {
    id:root

    property var curDate: []
    property real delegateSpacing: 10
    property alias horizontalSpacing: diaryGridView.horizontalSpacing
    property alias verticalSpacing: diaryGridView.verticalSpacing
    property real backgroundRadius: 10
    property string backgroundColor: "#cbd9ed"
    property real backgroundAddButtonRadius: 10
    property string backgroundAddButtonColor: "#e5ecff"
    property string addButtonSVGColor: "#00046d"
    property string addButtonSVGSourc: "./svg/add.svg"
    property string backgroundAddButtonBorderColor: backgroundColor

    property bool isDiaryTextEditorActive: false

    signal diaryUpdate(var x, var y, var z)

    onDiaryUpdate: (x,y,z) =>{
        myModel.updateModel(x, y, z)
        isDiaryTextEditorActive = false
    }

    Control {

        anchors.centerIn: parent
        height: parent.height*0.9
        width: parent.width*0.9

        clip: true

        leftPadding: horizontalSpacing
        topPadding: verticalSpacing

        background: Rectangle {
            color: backgroundColor
            radius: backgroundRadius
        }

        contentItem: GridView {
            id: diaryGridView

            property real horizontalSpacing: delegateSpacing
            property real verticalSpacing: delegateSpacing

            property real preferredCellWidth: 100
            property int preferredCellCount: Math.round(width / preferredCellWidth)

            cellWidth: width / preferredCellCount
            cellHeight: cellWidth * 0.8

            interactive: contentHeight > height ? !isDiaryTextEditorActive : false


            model: myModel

            delegate: Button {
                id:delegateId

                width: GridView.view.cellWidth - GridView.view.horizontalSpacing
                height: GridView.view.cellHeight - GridView.view.verticalSpacing

                palette.base: "#f2f0d8"
                palette.button: "#ebe8c9"


                text: diary

                enabled: !root.isDiaryTextEditorActive

                onClicked: {
                    enabled = true
                    editorText.text = delegateId.text
                    text = ""
                    diaryTextEditor.visible = true
                    root.isDiaryTextEditorActive = true
                }

                onPressAndHold: {
                    var tableKeys = ["id"]
                    var tableKeysValue = [id]
                    dataChanger.delVal("Diary", tableKeys, tableKeysValue)

                    GridView.view.diaryUpdate(curentDate[0], curentDate[1], curentDate[2])
                }

                Rectangle {
                    id: diaryTextEditor

                    visible: false
                    anchors.fill: parent
                    clip: true

                    TextEdit {
                        id: editorText
                        anchors.fill: parent

                        Keys.onReturnPressed: {
                            var tableName = "Diary"
                            var tableNames = ["diary", "year", "month", "day"]
                            var tableValues = ["'" + text + "'", curDate[0], curDate[1], curDate[2]]
                            dataChanger.changeValueInTable(tableName,tableNames,tableValues,["Id"],[id])
                            diaryTextEditor.visible = false

                            root.diaryUpdate(curDate[0], curDate[1], curDate[2])
                        }
                    }
                }
            }
        }
    }

    Button {
        width: parent.width > parent.height ? parent.height/4 : parent.width/4
        height: width

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        contentItem: Image {
            height: parent.height
            width: parent.width
            sourceSize.width: parent.width*10
            sourceSize.height: parent.height*10
            source: addButtonSVGSourc

            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: addButtonSVGColor
            }
        }

        background: Rectangle {
            radius: backgroundRadius
            color: parent.pressed ?  "white" : backgroundAddButtonColor
            border.color: backgroundAddButtonBorderColor
            Behavior on color {ColorAnimation{duration: 100}}
        }

        onClicked: {
            var tableName = "Diary"
            var tableNames = ["diary", "year", "month", "day"]
            var tableValues = ["''", curentDate[0], curentDate[1], curentDate[2]]
            dataChanger.inDB(tableName, tableNames, tableValues)

            tableName = "Dates"
            tableNames = ["year", "month", "day"]
            tableValues = [curentDate[0], curentDate[1], curentDate[2]]
            dataChanger.inDB(tableName, tableNames, tableValues)

            root.diaryUpdate(curentDate[0], curentDate[1], curentDate[2])
        }
    }
}

