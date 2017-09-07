import QtQuick 2.0
import VPlay 2.0
import QtQuick.Controls.Styles 1.0

ButtonVPlay{
    id:imageButton

    height:parent.height

    property int borderWidth: 1
    property color borderColor: "black"
    property int radius: 3
    property color initColor: "white"
    property color lastColor:"black"
    property alias image: image

    property alias hoverRectangle: hoverRectangle


    style: ButtonStyle {
      background: Rectangle {
        border.width: imageButton.borderWidth
        border.color: imageButton.borderColor
        radius: imageButton.radius

        // add a gradient as background
        gradient: Gradient {
          // take color as the first color
          GradientStop { position: 0.0; color: imageButton.initColor }

          GradientStop { position: 1.0; color: imageButton.lastColor}
        }
      }
    }


    MultiResolutionImage {
      id: image

      anchors.fill: parent
      anchors.margins: 1

      fillMode: Image.PreserveAspectFit
    }

    Rectangle {
      id: hoverRectangle

      anchors.fill: parent

      radius: imageButton.radius
      color: "white"

      // when the mouse hovers over the button, this rectangle is slightly visible
      opacity: hovered ? 0.3 : 0
    }
  }


