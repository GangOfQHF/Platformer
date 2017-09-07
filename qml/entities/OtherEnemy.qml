import QtQuick 2.0
import VPlay 2.0


EntityBase {
    id: otherEnemy
    entityType: "otherEnemy"
    width: 42
    height: 24

    MultiResolutionImage {
        id: otherImage
        anchors.fill: parent
        source: "../../assets/opponent/spikes.png"
    }

    BoxCollider {
        id: otherCollpder
        width: otherImage.width
        height: 8

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        collisionTestingOnlyMode: true
        bodyType: Body.Static

        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            var collidedEntityType = collidedEntity.entityType
            if(collidedEntityType === "player"){
                if(player.isBig === false) {
                    player.visible = false
                    audio.playSound("playerDie")
                    gameScene.dieRec = true
                }
                else {
                    player.isBig = false
                    audio.playSound("opponentJumperDie")
                    player.resetImageAnchor()

                }
            }
        }
    }
}
