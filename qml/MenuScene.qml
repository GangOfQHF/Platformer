import QtQuick 2.0
import VPlay 2.0
import "common"
SceneBase{
    id:menuScene

    Rectangle{
        id:bcg
        anchors.fill: menuScene.gameWindowAnchorItem


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ccff99" }
            GradientStop { position: 0.9; color: "#ccffcc" }
            GradientStop { position: 1.0; color: "#ffffcc" }
        }

    }



    Rectangle{
        id:header
        height: 95

        radius: 20
        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.margins: 5

        //        color: "#ffcccc"
        color:"#ccffcc"

        MultiResolutionImage {
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 10

            source: "../assets/menu/header.png"
        }

    }

    ImageButton{
        id:playButton
        image.source: "../assets/menu/playButton.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 70

        initColor:"#ffffcc"
        lastColor:"#ffff99"

        borderColor: "transparent"

        MouseArea{
            anchors.fill: parent
            onClicked : {
                audio.playSound("click")
                gameWindow.state = "game"
                gameScene.gameRunning = true
                gameScene.level1Visible = true
                gameScene.level2Visible = false
            }
        }


    }

    MultiResolutionImage {
      source: "../assets/logo-vp/logo-vp.png"

      anchors.right: parent.right
      anchors.rightMargin: 30
      anchors.top: header.bottom
      anchors.topMargin: 150

      MouseArea {
        anchors.fill: parent
        onClicked: {
          nativeUtils.displayMessageBox(qsTr("V-Play Game Engine"), qsTr("This game is built with V-Play Game Engine. The source code is available in the free V-Play SDK - so you can build your own platformer in minutes!\n\nVisit V-Play.net now? \n(It contains a tutorial how to use the V-Play Level Editor to create your own platform game and more details)"), 2)
        }
      }
    }

//    ImageButton{
//        id:levelButton
//        image.source:"../assets/menu/levelsButton.png"

//        width: 150
//        height: 40

//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: playButton.bottom
//        anchors.topMargin: 40
//        initColor:"#ffffcc"
//        lastColor:"#ffff99"

//        borderColor: "transparent"
//    }
}
