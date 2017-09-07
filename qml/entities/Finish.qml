import QtQuick 2.0
import VPlay 2.0

EntityBase{
    id:finish
    entityType: "finish"

    width:gameScene.gridSize
    height: gameScene.gridSize

    MultiResolutionImage{
        id:finishImage
        source: "../../assets/finish/finish.png"
        //         source: "../../assets/coin/coin.png"
        anchors.fill: finishCollider
        visible: true
    }

    BoxCollider{
        id:finishCollider
        bodyType: Body.Static
        anchors.fill: parent

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                gameScene.pass = true
                audio.playSound("finish")
                gameRunning = false
            }
        }




    }

}
