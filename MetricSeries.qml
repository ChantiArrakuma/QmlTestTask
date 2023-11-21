import QtQuick 2.15
import QtCharts 2.15

LineSeries {
    id: root

    pointsVisible: true

    width: 4

    property var coordX: []
    property var coordY: []
    property real xMultiplier: 1
    property real yMultiplier: 1
    property var curDate: []

    function getCoord(coord) {
        var coordXstr = ""
        var coordYstr = ""
        coordXstr += coord.x
        coordYstr += coord.y
        coordX.push(coordXstr)
        coordY.push(coordYstr)
    }

    onPointAdded:(x)=> getCoord(at(x))

    onClicked: {
        var min = 1439*2
        var minX = 0
        var minY = 0
        for(var i = 0; i != coordX.length; i++){

            var potentionalMin = Math.sqrt((Math.pow((point.x - coordX[i]), 2)
                                            + Math.pow((point.y - coordY[i]), 2)))
            if(min >= potentionalMin){
                min = potentionalMin
                minX = coordX[i]
                minY = coordY[i]
            }
        }

        if(min < 10){
            remove(minX, minY)
            var minute = minX*xMultiplier % 60
            var hour = (minX*xMultiplier - minute)/60

            var tableName = "MetricValues"
            var tableKeys = ["name", "value", "year", "month", "day", "hour", "minute"]
            var tableKeysValues = ["'"+name+"'", minY*yMultiplier, curDate[0], curDate[1],curDate[2], hour, minute]

            dataChanger.delVal(tableName, tableKeys, tableKeysValues)
            updateSeries()
        }
    }

    function updateSeries(){
        var columns = ["name","value","hour", "minute"]
        var tableKeys = ["name", "year", "month", "day"]
        var tableKeysValue = [name, curDate[0], curDate[1], curDate[2]]
        var tableName = "MetricValues"
        var respons = []
        var maxValueX = 0
        var lastValueY = 0

        respons = dataChanger.tableValues(tableName, columns, tableKeys, tableKeysValue)

        root.clear()
        if(Number(respons[1]/10))
            root.append(-0.00001, Number(respons[1]))
        else
            root.append(-0.00001, 0)

        for(var i = 0; i != respons.length; i+=columns.length){
            var xVal = (Number(respons[i+2])*60 + Number(respons[i+3]))
            var yVal = respons[i + 1]
            root.append(xVal, yVal)
            if(xVal >= maxValueX){
                maxValueX = xVal
                lastValueY = yVal
            }
        }
        root.append(1439, lastValueY)
    }
}
