import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level
    // we need to specify the width to get correct debug draw for our physics
    // the PhysicsWorld component fills it's parent by default, which is the viewPort Item of the gameScene and this item uses the size of the level
    // NOTE: thy physics will also work without defining the width here, so no worries, you can ignore it untill you want to do some physics debugging
    width: 70 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12

    // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size




    function resetBlock()
    {
        block1.x = platf4.x + 20
//        block1.bottom = platf4.top
        block1.alive = true
        block1.visb = true
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

    function createCoin4(name,num)
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
        size: 6
    }
    Ground {
        row: 8
        column: 0
        size: 2
    }
    Platform {
        id:platf1
        row: 3
        column: 3
        size: 4
    }


    Platform {
        id:platf2
        row: 7
        column: 6
        size: 4
    }

    Platform {
        id:platf3
        row: 11
        column: 3
        size: 2
    }


    Ground {
        id:ground2
        row: 12
        column: 0
        size: 30
    }
    Platform {
        id:platf4
        row: 17
        column: 3
        size: 10
    }

    Ground{
        row:34
        column: 0
        size:2
    }

    Platform{
       id:platf5
       row:45
       column: 3
       size:5
    }

    Platform{
        id:platf6
        row:50
        column: 6
        size:4
    }

    Ground{
        id:ground
        row:52
        column: 0
        size:10
    }

    Finish{
        x:ground.x + 9 * gameScene.gridSize
        y:ground.y - ground.height
    }


    Component.onCompleted: {
        createCoin(platf1,2)
        createCoin(platf2,4)
//        createCoin(platf3,2)
        createCoin4(platf4,5)
        createCoin(platf6,2)
//        createCoin(platf6)
    }

    OtherEnemy{
        id:other1
        x:ground2.x + 20*gameScene.gridSize
        anchors.bottom: ground2.top
    }

    OtherEnemy{
        anchors.left: other1.right
        anchors.bottom: ground2.top
    }

    BlockEnemy {
        id: block1
        x: platf4.x + 20
        anchors.bottom: platf4.top

        MovementAnimation {
            id: moveAnimation
            target: block1
            property: "x"
            maxPropertyValue: platf4.x + platf4.width
            minPropertyValue: platf4.x
            velocity: 30
            running: true
            onLimitReached: {
                block1.x === platf4.x + platf4.width ? velocity = -30 : velocity = 30
            }
        }
    }
}
