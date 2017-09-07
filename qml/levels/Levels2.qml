import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level2
    width: 42 * gameScene.gridSize


    function resetBlock()
    {
        block2.x = platf1.x + 20
//        block1.bottom = platf4.top
        block2.alive = true
        block2.visb = true
    }
    function createCoin(name,num)
    {
        var n = 0;
        for(var i = 0;i < num;++i)
        {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Coin.qml"))
            var new_coin = entityManager.getLastAddedEntity()
            new_coin.x = name.x + n * new_coin.width
            new_coin.y = name.y - name.height - 10
            ++n
        }
    }

    function createCoin1(name,num)
    {
        var n = 0;
        for(var i = 0;i < num;++i)
        {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Coin.qml"))
            var new_coin = entityManager.getLastAddedEntity()
            new_coin.x = name.x + n * new_coin.width
            new_coin.y = name.y - name.height - 22
            ++n
        }
    }

    Ground {
        row: 0
        column: 0
        size: 4
    }
    Platform {
        id:platf1
        row: 4
        column: 3
        size:8
    }
    Platform {
        id: platform1
        row: 14
        column: 5
        size: 2
        MovementAnimation{
            id: movePlatform1
            target: parent
            property: "x"
            maxPropertyValue: 17 * gameScene.gridSize
            minPropertyValue: 13 * gameScene.gridSize
            velocity: 30
            running: true
            onLimitReached: {
                parent.x == 17 * gameScene.gridSize ? velocity = -30 : velocity = 30
            }
        }
    }
    Platform {
        id:platf2
        row: 20
        column: 7
        size: 2
    }//mo gu

    Mushroom {
        id: mushroom1
        anchors.bottom: platf2.top
        anchors.bottomMargin: 12
        anchors.horizontalCenter: platf2.horizontalCenter
    }

    Ground {
        id: ground2
        row: 20
        column: 0
        size: 6
    }

    Platform {
        id:platform2
        row: 25
        column: 3
        size: 3
        MovementAnimation{
            id: movePlatform2
            target: parent
            property: "y"
            maxPropertyValue: level1.height - 3*gameScene.gridSize
            minPropertyValue: level1.height - 7*gameScene.gridSize
            velocity: 30
            running: true
            onLimitReached: {
                parent.y == level1.height - 3*gameScene.gridSize ? velocity = -30 : velocity = 30
            }
        }
    }

    Platform {
        id:platf3
        row: 30
        column: 7
        size: 3
    }

    Platform {
        id:platf4
        row: 34
        column: 3
        size: 4
    }
    Ground {
        id: ground3
        row: 35
        column: 0
        size: 10
    }
    Platform {
        id:platf5
        row: 40
        column: 3
        size: 2

        MovementAnimation{
            id: movePlatform3
            target: parent
            property: "y"
            maxPropertyValue: level1.height - 4*gameScene.gridSize
            minPropertyValue: level1.height - 7*gameScene.gridSize
            velocity: 30
            running: true
            onLimitReached: {
                parent.y == level1.height - 4*gameScene.gridSize ? velocity = -30 : velocity = 30
            }
        }
    }
    Platform {
        row: 45
        column: 7
        size: 3
    }
    Platform {
        row: 50
        column: 3
        size: 2

        MovementAnimation{
            id: movePlatform4
            target: parent
            property: "x"
            maxPropertyValue: 54 * gameScene.gridSize
            minPropertyValue: 50 * gameScene.gridSize
            velocity: 30
            running: true
            onLimitReached: {
                parent.x == 54 * gameScene.gridSize ? velocity = -30 : velocity = 30
            }
        }
    }

    Ground {
        id:ground
        row: 57
        column: 0
        size: 10
    }

    Finish{
        x:ground.x + 9 * gameScene.gridSize
        y:ground.y - ground.height
    }

    function createAllCoin()
    {
        createCoin1(platf1,8)
//        createCoin(platf2,2)
        createCoin(ground2,3)
        createCoin1(ground3,10)
        createCoin(ground,3)
    }

    BlockEnemy {
        id: block2
        x: platf1.x + 20
        anchors.bottom: platf1.top

        MovementAnimation {
            id: moveAnimation
            target: block2
            property: "x"
            maxPropertyValue: platf1.x + platf1.width
            minPropertyValue: platf1.x
            velocity: 30
            running: true
            onLimitReached: {
                block2.x === platf1.x + platf1.width ? velocity = -30 : velocity = 30
            }
        }
    }


    OtherEnemy {
        id: other
        anchors.bottom: ground2.top
        x: ground2.x + 3.5*gameScene.gridSize
    }

    BlockEnemy {
        id: block3
        x: ground3.x + 20
        anchors.bottom: ground3.top

        MovementAnimation {
            id: moveAnimation3
            target: block3
            property: "x"
            maxPropertyValue: ground3.x + ground3.width
            minPropertyValue: ground3.x
            velocity: 30
            running: true
            onLimitReached: {
                block3.x === ground3.x + ground3.width ? velocity = -30 : velocity = 30
            }
        }
    }

    OtherEnemy {
        id: other1
        anchors.bottom: ground.top
        x: ground.x + 5*gameScene.gridSize
    }

    function setMushroomVisible()
    {
        mushroom1.visible = true
    }

}
