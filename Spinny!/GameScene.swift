//
//  GameScene.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/24/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var tapToPlayButton = SKSpriteNode()
    var soundButton = SKSpriteNode()
    var musicButton = SKSpriteNode()
    let shareButtonExtended = SKSpriteNode(imageNamed: "shareButtonExtended")
    let facebookButton = SKSpriteNode(imageNamed: "facebookButton")
    let appStoreButton = SKSpriteNode(imageNamed: "appStoreButton")
    var shareButtonTapped = false
    var moreButtonTapped = false
    let moreButtonExtended = SKSpriteNode(imageNamed: "moreButtonExtended")
    var darkModeButton = SKSpriteNode()
    var accButton = SKSpriteNode()
    let moreInButton = SKSpriteNode(imageNamed: "moreInButton")
    var wheel = SKSpriteNode()
    var logo = SKSpriteNode()
    var magicBackground = SKEmitterNode()
    var mainstatusLabel = SKLabelNode()
    var beststatusLabel = SKLabelNode()
    
    override func didMoveToView(view: SKView) {        
        
        if userDefaults.boolForKey("isAppAlreadyLaunchedOneTime") == true {
            userDefaults.setBool(false, forKey: "isAppAlreadyLaunchedOneTime")
            var tutorialScene = TutorialScene(size: self.size)
            tutorialScene.scaleMode = SKSceneScaleMode.AspectFill
            let transition = SKTransition.pushWithDirection(.Down, duration: 0.5)
            self.scene!.view?.presentScene(tutorialScene, transition: transition)
        }
        
        println(userDefaults.valueForKey("currentScore"))
        println(userDefaults.valueForKey("bestScore"))
        
        rightButtonTapped = false
        leftButtonTapped = false
        
        let screenWidth = scene!.view!.bounds.width
        let screenHeight = scene!.view!.bounds.height
        shareButtonTapped = false
        moreButtonTapped = false
        
        if userDefaults.integerForKey("currentScore") > userDefaults.integerForKey("bestScore") {
            userDefaults.setInteger(userDefaults.integerForKey("currentScore"), forKey: "bestScore")
        }
        
        // play background music
        playMusic()
        
        if userDefaults.boolForKey("gameMusic") == true {
            audioPlayer.play()
        }
        
        if userDefaults.boolForKey("darkMode") == true {
            setDarkMode(true)
        } else {
            setDarkMode(false)
        }
        
        if userDefaults.boolForKey("gameSounds") == true {
            soundButton = SKSpriteNode(imageNamed: "soundOnButton")
        } else {
            soundButton = SKSpriteNode(imageNamed: "soundOffButton")
        }
        soundButton.zPosition = 3
        soundButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        soundButton.position = CGPoint(x: screenWidth * 0.2, y: logo.position.y - 170)
        soundButton.name = "soundButton"
        addChild(soundButton)
        
        if userDefaults.boolForKey("gameMusic") == true {
            musicButton = SKSpriteNode(imageNamed: "musicOnButton")
        } else {
            musicButton = SKSpriteNode(imageNamed: "musicOffButton")
        }
        musicButton.zPosition = 3
        musicButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        musicButton.position = CGPoint(x: screenWidth * 0.4, y: logo.position.y - 170)
        musicButton.name = "musicButton"
        addChild(musicButton)
        
        let shareButton = SKSpriteNode(imageNamed: "shareButton")
        shareButton.zPosition = 3
        shareButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        shareButton.position = CGPoint(x: screenWidth * 0.6 , y: logo.position.y - 170)
        shareButton.name = "shareButton"
        addChild(shareButton)
        
        shareButtonExtended.anchorPoint = CGPoint(x: 0.5, y: 1)
        shareButtonExtended.position = shareButton.position
        shareButtonExtended.zPosition = shareButton.zPosition-1
        shareButtonExtended.alpha = 0
        addChild(shareButtonExtended)
        
        facebookButton.position = CGPoint(x: shareButtonExtended.position.x, y: shareButtonExtended.position.y - shareButtonExtended.size.height/2)
        facebookButton.zPosition = shareButtonExtended.zPosition+1
        facebookButton.alpha = 0
        facebookButton.name = "facebookButton"
        
        appStoreButton.position = CGPoint(x: shareButtonExtended.position.x, y: shareButtonExtended.position.y - shareButtonExtended.size.height + 27)
        appStoreButton.zPosition = shareButtonExtended.zPosition+1
        appStoreButton.alpha = 0
        appStoreButton.name = "appStoreButton"
        
        let moreButton = SKSpriteNode(imageNamed: "moreButton")
        moreButton.zPosition = 3
        moreButton.anchorPoint = CGPoint(x: 0.5, y: 1)
        moreButton.position = CGPoint(x: screenWidth * 0.8, y: logo.position.y - 170)
        moreButton.name = "moreButton"
        addChild(moreButton)
        
        moreButtonExtended.anchorPoint = CGPoint(x: 0.5, y: 1)
        moreButtonExtended.position = moreButton.position
        moreButtonExtended.zPosition = moreButton.zPosition-1
        moreButtonExtended.alpha = 0
        addChild(moreButtonExtended)
        
        
        if userDefaults.boolForKey("darkMode") == true {
            darkModeButton = SKSpriteNode(imageNamed: "darkModeOnButton")
        } else {
            darkModeButton = SKSpriteNode(imageNamed: "darkModeOffButton")
        }
        darkModeButton.position = CGPoint(x: moreButtonExtended.position.x, y: moreButtonExtended.position.y - moreButtonExtended.size.height * 0.37)
        darkModeButton.zPosition = moreButtonExtended.zPosition+1
        darkModeButton.alpha = 0
        darkModeButton.name = "darkModeButton"
        
        if userDefaults.boolForKey("accMode") == true {
            accButton = SKSpriteNode(imageNamed: "accOnButton")
        } else {
            accButton = SKSpriteNode(imageNamed: "accOffButton")
        }
        accButton.position = CGPoint(x: moreButtonExtended.position.x, y: moreButtonExtended.position.y - moreButtonExtended.size.height * 0.63)
        accButton.zPosition = moreButtonExtended.zPosition+1
        accButton.alpha = 0
        accButton.name = "accButton"
        
        moreInButton.position = CGPoint(x: moreButtonExtended.position.x, y: moreButtonExtended.position.y - moreButtonExtended.size.height + 27)
        moreInButton.zPosition = moreButtonExtended.zPosition+1
        moreInButton.alpha = 0
        moreInButton.name = "moreInButton"
        
        wheel = Wheel.addWheel(self, size: Double(screenHeight/4))
        wheel.position = CGPoint(x: screenWidth/2, y: screenHeight/6)
        
        if userDefaults.boolForKey("darkMode") == true {
            tapToPlayButton = SKSpriteNode(imageNamed: "tapToPlayButtonDark")
        } else {
            tapToPlayButton = SKSpriteNode(imageNamed: "tapToPlayButton")
        }
        tapToPlayButton.position = CGPoint(x: wheel.position.x, y: wheel.position.y + wheel.size.height/2 + 25)
        tapToPlayButton.zPosition = moreButtonExtended.zPosition-1
        
        let waitShort = SKAction.waitForDuration(0.3)
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        let waitLong = SKAction.waitForDuration(1)
        let fadeIn = SKAction.fadeInWithDuration(0.1)
        let blink = SKAction.sequence([waitLong, fadeOut, waitShort, fadeIn])
        
        tapToPlayButton.runAction(SKAction.repeatActionForever(blink))
        addChild(tapToPlayButton)
        
        
        if userDefaults.valueForKey("currentScore") != nil {
            let currentScore = userDefaults.integerForKey("currentScore")
            mainstatusLabel = SKLabelNode(text: "SCORE: \(currentScore)")
            mainstatusLabel.fontName = "System-Bold"
            mainstatusLabel.zPosition = shareButtonExtended.zPosition - 1
            mainstatusLabel.position = CGPoint(x: screenWidth/2, y: musicButton.position.y - 70)
            mainstatusLabel.verticalAlignmentMode = .Center
            mainstatusLabel.horizontalAlignmentMode = .Center
            mainstatusLabel.fontSize = 17
            
            if userDefaults.boolForKey("darkMode") == true {
                mainstatusLabel.fontColor = UIColor.whiteColor()
            } else {
                mainstatusLabel.fontColor = UIColor.darkGrayColor()
            }
            addChild(mainstatusLabel)
        }
        
        if userDefaults.valueForKey("bestScore") != nil {
            let bestScore = userDefaults.integerForKey("bestScore")
            beststatusLabel = SKLabelNode(text: "BEST: \(bestScore)")
            beststatusLabel.fontName = "System-Bold"
            beststatusLabel.zPosition = shareButtonExtended.zPosition - 1
            beststatusLabel.position = CGPoint(x: screenWidth/2, y: musicButton.position.y - 95)
            beststatusLabel.verticalAlignmentMode = .Center
            beststatusLabel.horizontalAlignmentMode = .Center
            beststatusLabel.fontSize = 17
            
            if userDefaults.boolForKey("darkMode") == true {
                beststatusLabel.fontColor = UIColor.whiteColor()
            } else {
                beststatusLabel.fontColor = UIColor.darkGrayColor()
            }
            addChild(beststatusLabel)
        }
        
        
    }
    
    func changeDarkMode(darkMode: Bool) {
        logo.removeFromParent()
        magicBackground.removeFromParent()
        setDarkMode(darkMode)
    }
    
    func setDarkMode(darkMode: Bool) {
        
        let screenWidth = scene!.view!.bounds.width
        let screenHeight = scene!.view!.bounds.height
        let image: String!
        
        if darkMode == true {
            image = "logoDark"
            backgroundColor = Colors.grayColor
            magicBackground = SKEmitterNode(fileNamed: "MagicDarkParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
            mainstatusLabel.fontColor = UIColor.whiteColor()
            beststatusLabel.fontColor = UIColor.whiteColor()
        } else {
            image = "logo"
            backgroundColor = UIColor.whiteColor()
            magicBackground = SKEmitterNode(fileNamed: "MagicParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
            mainstatusLabel.fontColor = UIColor.darkGrayColor()
            beststatusLabel.fontColor = UIColor.darkGrayColor()
        }
        
        logo = SKSpriteNode(imageNamed: image!)
        logo.anchorPoint = CGPoint(x: 0.5, y: 1)
        logo.position = CGPoint(x: screenWidth/2, y: screenHeight-30)
        addChild(logo)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if location.y <= tapToPlayButton.position.y + 50 {
                if nodeAtPoint(location).name == nil {
                    var playScene = PlayScene(size: self.size)
                    playScene.scaleMode = SKSceneScaleMode.AspectFill
                    self.scene!.view?.presentScene(playScene)
                }
                
            }
            
            if nodeAtPoint(location).name == "soundButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    soundButton.texture = SKTexture(imageNamed: "soundOffButton")
                    userDefaults.setBool(false, forKey: "gameSounds")
                } else {
                    soundButton.texture = SKTexture(imageNamed: "soundOnButton")
                    userDefaults.setBool(true, forKey: "gameSounds")
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
            }
            
            if nodeAtPoint(location).name == "musicButton" {
                if userDefaults.boolForKey("gameMusic") == true {
                    musicButton.texture = SKTexture(imageNamed: "musicOffButton")
                    userDefaults.setBool(false, forKey: "gameMusic")
                    audioPlayer.stop()
                } else {
                    musicButton.texture = SKTexture(imageNamed: "musicOnButton")
                    userDefaults.setBool(true, forKey: "gameMusic")
                    audioPlayer.play()
                }
            }
            
            if nodeAtPoint(location).name == "moreInButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                var moreScene = MoreScene(size: self.size)
                moreScene.scaleMode = SKSceneScaleMode.AspectFill
                let transition = SKTransition.pushWithDirection(.Left, duration: 0.5)
                self.scene!.view?.presentScene(moreScene, transition: transition)
            }
            
            if nodeAtPoint(location).name == "accButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                if userDefaults.boolForKey("accMode") == true {
                    accButton.texture = SKTexture(imageNamed: "accOffButton")
                    userDefaults.setBool(false, forKey: "accMode")
                    
                    wheel.texture = SKTexture(imageNamed: "wheel")
                    if userDefaults.boolForKey("gameSounds") == true {
                        self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true), SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)]))
                    }
                    let alert = UIAlertView(title: "Accessibility Disabled",
                        message: "To re-enable, tap the accessibility button again",
                        delegate: nil,
                        cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    accButton.texture = SKTexture(imageNamed: "accOnButton")
                    userDefaults.setBool(true, forKey: "accMode")
                    wheel.texture = SKTexture(imageNamed: "wheelAcc")
                    if userDefaults.boolForKey("gameSounds") == true {
                        self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true), SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)]))
                    }
                    let alert = UIAlertView(title: "Accessibility Enabled",
                        message: "To disable, tap the accessibility button again",
                        delegate: nil,
                        cancelButtonTitle: "OK")
                    alert.show()
                }
            }
            
            if nodeAtPoint(location).name == "darkModeButton" {
                
                if userDefaults.boolForKey("darkMode") == true {
                    darkModeButton.texture = SKTexture(imageNamed: "darkModeOffButton")
                    tapToPlayButton.texture = SKTexture(imageNamed: "tapToPlayButton")
                    userDefaults.setBool(false, forKey: "darkMode")
                    changeDarkMode(false)
                    if userDefaults.boolForKey("gameSounds") == true {
                        self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true), SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)]))
                    }
                    let alert = UIAlertView(title: "Dark Mode Disabled",
                        message: "To re-enable, tap the dark mode button again",
                        delegate: nil,
                        cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    darkModeButton.texture = SKTexture(imageNamed: "darkModeOnButton")
                    tapToPlayButton.texture = SKTexture(imageNamed: "tapToPlayButtonDark")
                    userDefaults.setBool(true, forKey: "darkMode")
                    changeDarkMode(true)
                    if userDefaults.boolForKey("gameSounds") == true {
                        self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true), SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)]))
                    }
                    let alert = UIAlertView(title: "Dark Mode Enabled",
                        message: "To disable, tap the dark mode button again",
                        delegate: nil,
                        cancelButtonTitle: "OK")
                    alert.show()
                }
            }
            
            
            if nodeAtPoint(location).name == "facebookButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                UIApplication.sharedApplication().openURL(NSURL(string : "https://www.facebook.com/profile.php?id=707734849373258")!)
            }
            
            if nodeAtPoint(location).name == "appStoreButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                UIApplication.sharedApplication().openURL(NSURL(string : "https://itunes.apple.com/us/app/spinny!/id1003080348?ls=1&mt=8")!)
            }
            
            if nodeAtPoint(location).name == "moreButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                if moreButtonTapped == false {
                    moreButtonTapped = true
                    addChild(darkModeButton)
                    addChild(accButton)
                    addChild(moreInButton)
                    moreButtonExtended.runAction(SKAction.fadeInWithDuration(0.1))
                    darkModeButton.runAction(SKAction.fadeInWithDuration(0.1))
                    accButton.runAction(SKAction.fadeInWithDuration(0.1))
                    moreInButton.runAction(SKAction.fadeInWithDuration(0.1))
                    wheel.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.3))
                    logo.runAction(SKAction.fadeAlphaTo(0.3, duration: 0.5))
                    
                } else if moreButtonTapped == true {
                    moreButtonTapped = false
                    darkModeButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    accButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    moreInButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    moreButtonExtended.runAction(SKAction.fadeOutWithDuration(0.1))
                    wheel.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                    logo.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                }
            }
            
            if nodeAtPoint(location).name == "shareButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                if shareButtonTapped == false {
                    shareButtonTapped = true
                    addChild(facebookButton)
                    addChild(appStoreButton)
                    shareButtonExtended.runAction(SKAction.fadeInWithDuration(0.1))
                    facebookButton.runAction(SKAction.fadeInWithDuration(0.1))
                    appStoreButton.runAction(SKAction.fadeInWithDuration(0.1))
                    wheel.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.3))
                    logo.runAction(SKAction.fadeAlphaTo(0.3, duration: 0.5))
                    
                } else if shareButtonTapped == true {
                    shareButtonTapped = false
                    shareButtonExtended.runAction(SKAction.fadeOutWithDuration(0.1))
                    facebookButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    appStoreButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    wheel.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                    logo.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                }
            }
            
            if nodeAtPoint(location).name != "shareButton"{
                if shareButtonTapped == true {
                    shareButtonTapped = false
                    shareButtonExtended.runAction(SKAction.fadeOutWithDuration(0.1))
                    facebookButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    appStoreButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    wheel.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                    logo.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                }
            }
            
            if nodeAtPoint(location).name != "moreButton"{
                if moreButtonTapped == true {
                    moreButtonTapped = false
                    moreButtonExtended.runAction(SKAction.fadeOutWithDuration(0.1))
                    darkModeButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    accButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    moreInButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                    
                    wheel.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                    logo.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
                }
            }
        }
    }
    
}
