import QtQuick 2.0
import VPlay 2.0

EntityBase{
    id:coin
    entityType: "coin"
    width:gameScene.gridSize
    height:gameScene.gridSize

    property bool collected: false

    // when the coin is collected, it shouldn't be visible anymore

    MultiResolutionImage{
        id:image
        source: "../../assets/coin/coin.png"
        visible:!collected
        anchors.fill:collider
    }


    CircleCollider{
        id:collider
        radius: parent.width / 2 - 3
        x:3
        y:3
        // disable collider when coin is collected
        active: !collected
        bodyType: Body.Static
        anchors.fill: parent
    }

    function collect() {
        console.debug("collect coin")
        coin.collected = true
        audio.playSound("collectCoin")
    }

    // reset coin
    function reset() {
      coin.collected = false
    }

}
