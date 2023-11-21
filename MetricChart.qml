import QtQuick 2.15
import QtCharts 2.15

ChartView {
    id: root

    backgroundColor: "transparent"
    plotAreaColor: "transparent"
    property var curDate: []
    antialiasing: true
    legend.visible: false

    function createSeries1(metric){

        var columnsColor = ["color"]
        var tableKeysColor = ["name"]
        var tableKeysValueColor = [metric]
        var tableNameColor = "Metric"
        color = dataChanger.tableValues(tableNameColor, columnsColor, tableKeysColor, tableKeysValueColor)[0]

        var comp;
        var newSeries;
        comp = Qt.createComponent("MetricSeries.qml")

        newSeries = comp.createObject(root, {
                                          "name": metric,
                                          "color": color,
                                          "curDate": curentDate,
                                      })
        newSeries.updateSeries()
        root.setAxisX(axisA, newSeries)
        root.setAxisY(axisR, newSeries)
    }

    function updateChart() {
        root.removeAllSeries()
        var columns = ["name"]
        var tableKeys = []
        var tableKeysValue = []
        var tableName = "Metric"
        var respons = dataChanger.tableValues(tableName, columns, tableKeys, tableKeysValue)
        for(var i = 0; i !== respons.length; i++)
            createSeries1(respons[i]) // !!!
    }

    Component.onCompleted: {
        updateChart()
    }

    LineSeries {
        axisAngular: axisAb
        axisRadial: axisR
    }
    ValueAxis {
        id: axisA

        objectName: "axisA"

        min: 0
        max: 1439

        visible: false
    }

    ValueAxis {
        id: axisR

        objectName: "axisR"

        min: 0
        max: 10
        visible: true
    }

    ValueAxis {
        id: axisAb

        min: 0
        max: 24
        visible: true
    }
}
