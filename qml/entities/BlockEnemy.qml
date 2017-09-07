import QtQuick 2.0
import VPlay 2.0


EntityBase {
    id: blockEnemy
    entityType: "blockEnemy"
    width: 25
    height: 25
    visible: visb ? true : false

    property bool alive: true
    property bool visb: true

    //    Behavior on visb {NumberAnimation { duration: 50}}

    MultiResolutionImage {
        id: blockImage
        anchors.fill: parent
        source: alive ? "../../assets/opponent/opponent_jumper.png" : "../../assets/opponent/opponent_jumper_dead.png"
    }

    BoxCollider {
        id: blockBottomCollider
        width: blockImage.width
        height: 20

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        collisionTestingOnlyMode: true
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            var collidedEntityType = collidedEntity.entityType
            if(collidedEntityType === "player"){
                if(player.isBig === false) {
                    player.visible = false
                    audio.playSound("playerDie")
                    dieRec = true
                }
                else
                {
                    player.isBig = false
                    audio.playSound("opponentJumperDie")
                    player.resetImageAnchor()
                }
            }
        }
    }



    BoxCollider {
        id:blockTopCollider
        width: blockImage.width - 3
        height: 1

        active: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        collisionTestingOnlyMode: true
        bodyType: Body.Static

        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            var collidedEntityType = collidedEntity.entityType
            if(collidedEntityType === "player"){
                alive = false
                visb = false
                audio.playSound("playHit")
            }
        }
    }

}
