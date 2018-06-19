import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Robot")

    Item{
        anchors.fill: parent

        Timer{
            id: timer
            interval: 50
            repeat: true
            onTriggered: {
                canvas.pos++
            }
        }

        Canvas{
            id: canvas
            anchors.fill: parent

            property var points: []

            property double scale: 6.0
            property point offset: Qt.point(scale*-140,0)
            property int pos: -1

            onPosChanged: {
                requestPaint()
            }

            onPaint: {
                if(points.length===0) return;

                var ctx = getContext("2d");
                context.clearRect(0, 0, canvas.width, canvas.height);
                ctx.fillStyle = Qt.rgba(1, 0, 0, 1);

                context.beginPath();
                context.moveTo(scale*points[0].x+offset.x, scale*points[0].y+offset.y);
                for(var i=1; i<points.length; i++){
                    context.lineTo(scale*points[i].x+offset.x, scale*points[i].y+offset.y);
                }
                context.lineTo(scale*points[0].x+offset.x, scale*points[0].y+offset.y);

                context.lineWidth = 1;
                context.strokeStyle = 'black';
                context.stroke();

                if(pos>=0 && pos<points.length){
                    var centerX = scale*points[pos].x+offset.x
                    var centerY = scale*points[pos].y+offset.y
                    var radius = 5;

                    context.beginPath();
                    context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
                    context.fillStyle = 'green';
                    context.fill();
                    context.lineWidth = 5;
                    context.strokeStyle = '#003300';
                    context.stroke();
                }
            }

            Component.onCompleted: {
                points = loader.getPath()
                requestPaint()
            }
        }
    }

    Button{
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 5

        text: timer.running ? qsTr("Stop") : qsTr("Start")

        onClicked: {
            if(timer.running)
                timer.stop()
            else
                timer.start()
        }
    }
}
