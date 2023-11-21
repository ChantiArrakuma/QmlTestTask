import QtQuick 2.15

Item {

    property real delegateHeight: 0

    Rectangle{
        anchors.top: parent.top
        width: parent.width
        height: (parent.height-delegateHeight)/2
        gradient: gradiantA
    }

    Rectangle{
        anchors.bottom: parent.bottom
        width: parent.width
        height: (parent.height-delegateHeight)/2
        gradient: gradiantB
    }

    Gradient{
        id: gradiantA
        GradientStop {position: 0.2; color: parentBgColor}
        GradientStop {position: 0.4; color: "transparent"}
        GradientStop {position: 0.98; color: "white"}
        GradientStop {position: 1.0; color: fontColor}
    }
    Gradient{
        id: gradiantB
        GradientStop {position: 0.00; color: fontColor}
        GradientStop {position: 0.02; color: "white"}
        GradientStop {position: 0.6; color: "transparent"}
        GradientStop {position: 0.8; color: parentBgColor}
    }
}
