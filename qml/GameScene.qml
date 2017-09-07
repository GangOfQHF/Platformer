import VPlay 2.0
import QtQuick 2.0
import "entities"
import "levels"
import "common"

SceneBase{
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 480
    height: 320
    gridSize: 32

    property int offsetBeforeScrollingStarts: 240
    property bool gameRunning: false
    property alias pass:passRec.visible

    property alias dieRec: infoRec.visible

    property alias level1Visible:level1.visible
    property alias level2Visible: level2.visible

    property int levelFlag: 0

    // the whole screen is filled with an incredibly beautiful blue ...
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        id:bcg1
        sourceImage: "../assets/background/layer2.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
    }
    ParallaxScrollingBackground {
        id:bcg2
        sourceImage: "../assets/background/layer1.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        ratio: Qt.point(0.6,0)
    }



    // this is the moving item containing the level and player
    Item {
        id: viewPort
        height: level1.height
        width: level1.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)

        }



        EntityManager {
            id: entityManager
            entityContainer: levelFlag === 0 ? level1 : level2
        }

        Level1 {
            id: level1
            visible: true
        }

        Levels2{
            id:level2
            visible:false
        }

        Player {
            id: player
            x: 20
            y: 100
        }

        ResetSensor {
            id:resetsensor
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                gameRunning = false
                audio.closePlayMusic()
                infoRec.visible = true
            }

            // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
            Rectangle {
                anchors.fill: parent
                color: "yellow"
                opacity: 0.5
            }
        }
    }
    Timer{
        id: gameTimer
        running: gameRunning // time only counts down if game is running
        repeat: true
        onTriggered:{
            player.time--
            if(player.time === 0)
            {
                gameRunning = false
                audio.closePlayMusic()
                infoRec.visible = true
            }
        }

    }

    Row {
        anchors.top: parent.top
        z: 2 // make sure the HUD is always on top
        // info text area
        Text {id:scoreText;width:200; height:40; text:"Score:" + player.score}
        // display remaining time
        Text {id:timeText; height:40; text:"Time: "+player.time}
    }

    Rectangle{
        id:infoRec
        visible: false
        width: 380
        height: 250
        z:10
        anchors.centerIn: parent
        color:"lightgrey"
        Text{
            id:text1
            text:"Game Over!"
            color: "red"
            anchors.centerIn: parent
            font.pixelSize:  20
            font.family: "Arial"
        }
        Row{
            x:80
            anchors.bottom:parent.bottom
            Text{
                text:"Restart"
                width: 200
                font.pixelSize:  14
                font.family: "Arial"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        player.visible = true
                        audio.playSound("click")
                        infoRec.visible = false
                        gameRunning = true
                        //reset player's position

                        player.x = 20
                        player.y = 100

                        player.isBig = false
                        // reset coins
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        level2.setMushroomVisible()
                        player.resetImageAnchor()

                        level1.resetBlock()
                        level2.resetBlock()
                        player.score = 0
                        if(levelFlag === 0){
                            player.time = 15
                        }
                        else if(levelFlag === 1){
                            player.time = 35
                        }

                        audio.openPlayMusic()
                    }
                }
            }


            Text{
                text:"Menu"
                height:40
                font.pixelSize:  14
                font.family: "Arial"
                //anchors.fill: parent
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        infoRec.visible = false
                        //                        gameRunning = true
                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 15
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        gameWindow.state = "menu"
                    }
                }
            }

        }
    }


    Rectangle{
        id:passRec
        visible: false
        width: 380
        height: 250
        z:10
        anchors.centerIn: parent
        color:"lightgreen"
        Text{
            id:text3
            text:"Congratulations,Pass!"
            color: "red"
            anchors.centerIn: parent
            font.pixelSize:  20
            font.family: "Arial"
        }
        Row{
            x:80
            anchors.bottom:parent.bottom
            Text{
                text:"Next"
                width: 200
                font.pixelSize:  14
                font.family: "Arial"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        levelFlag = 1
                        passRec.visible = false
                        gameRunning = true
                        level1.visible = false
                        level2.visible = true
                        level2.createAllCoin()
                       //reset player's position

                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 26
                        audio.openPlayMusic()
                    }
                }
            }


            Text{
                text:"Menu"
                height:40
                font.pixelSize:  14
                font.family: "Arial"
                //anchors.fill: parent
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        passRec.visible = false
                        //                        gameRunning = true
                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 15
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        gameWindow.state = "menu"

                    }
                }
            }

        }
    }

    // on desktops, you can move the player with the arrow keys, on mobiles we are using our custom inputs above to modify the controller axis values. With this approach, we only need one actual logic for the movement, always referring to the axis values of the controller
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            //            if(gameRunning===true){
            console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
                if(player.y >= 20)
                {
                     player.jump()
                }

            }
        }
    }


}

