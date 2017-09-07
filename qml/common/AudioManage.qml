import QtQuick 2.0
import VPlay 2.0
import QtMultimedia 5.0

Item{
    id:audioManager

    BackgroundMusic{
        id:menuBgm
        source: "../../assets/audio/music/menuMusic.mp3"
        autoPlay: true
    }

    BackgroundMusic {
        id: playMusic

        autoPlay: false

        source: "../../assets/audio/music/playMusic.mp3"
    }



    SoundEffectVPlay {
        id: playerJump
        source: "../../assets/audio/sounds/phaseJump1.wav"
    }

    SoundEffectVPlay {
        id: collectCoin
        source: "../../assets/audio/sounds/coin_3.wav"
    }

    SoundEffectVPlay {
        id: click
        source: "../../assets/audio/sounds/click1.wav"
    }

    SoundEffectVPlay {
      id: finish
      source: "../../assets/audio/sounds/coin_3.wav"
    }

    SoundEffectVPlay {
      id: playerHit
      source: "../../assets/audio/sounds/whizz.wav"
    }

    SoundEffectVPlay {
      id: collectMushroom
      source: "../../assets/audio/sounds/zapThreeToneUp.wav"
    }

    SoundEffectVPlay {
      id: opponentJumperDie
      source: "../../assets/audio/sounds/twitch.wav"
    }

    SoundEffectVPlay {
      id: playerDie
      source: "../../assets/audio/sounds/lose.wav"
    }


    function closeMenuBgm(){
        menuBgm.stop()
    }

    function openMenuBgm()
    {
        menuBgm.play()
    }

    function openPlayMusic()
    {
        playMusic.play()
    }

    function closePlayMusic()
    {
        playMusic.stop()
    }

    function playSound(sound) {
        if(sound === "playerJump")
            playerJump.play()
        else if(sound === "collectCoin")
            collectCoin.play()
        else if(sound === "click")
            click.play()
        else if(sound === "finish")
            finish.play()
        else if(sound === "playerDie")
            playerDie.play()
        else if(sound === "playHit")
            playerHit.play()
        else if(sound === "collectMushroom")
            collectMushroom.play()
        else if(sound === "opponentJumperDie")
            opponentJumperDie.play()
    }
}
