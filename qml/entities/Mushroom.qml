import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: mushroom
    entityType: "mushroom"
    width: 20
    height: 20
    visible: true

    onVisibleChanged: console.log("mushroom visible", visible)

    MultiResolutionImage {
        source: "../../assets/powerup/mushroom.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                console.log("Contact a mushroom")
                mushroom.visible = false
                player.isBig = true
                audio.playSound("collectMushroom")
                player.resizeImageAnchor()
                player.contacts++
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {

                player.contacts--
            }
        }
    }
}
