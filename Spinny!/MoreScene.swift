//
//  MoreScene.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit

class MoreScene: SKScene {
    
    var logo = SKSpriteNode()
    var magicBackground = SKEmitterNode()
    
//    func swipedRight(sender:UISwipeGestureRecognizer){
//        println("swiped right")
//        var gameScene = GameScene(size: self.size)
//        gameScene.scaleMode = SKSceneScaleMode.AspectFill
//        let transition = SKTransition.pushWithDirection(.Right, duration: 0.3)
//        self.scene!.view?.presentScene(gameScene, transition: transition)
//    }
    
    override func didMoveToView(view: SKView) {
        
//        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
//        swipeRight.direction = .Right
//        view.addGestureRecognizer(swipeRight)
        
        let screenWidth = scene!.view!.bounds.width
        let screenHeight = scene!.view!.bounds.height
        
        let image: String!
        let omarImage: String!
        let backImage: String!
        
        if userDefaults.boolForKey("darkMode") == true {
            image = "logoDarkSmall"
            omarImage = "omarDark"
            backImage = "backButtonDark"
            backgroundColor = Colors.grayColor
            magicBackground = SKEmitterNode(fileNamed: "MagicDarkParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
        } else {
            image = "logoSmall"
            omarImage = "omar"
            backImage = "backButton"
            backgroundColor = UIColor.whiteColor()
            magicBackground = SKEmitterNode(fileNamed: "MagicParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
        }
        logo = SKSpriteNode(imageNamed: image!)
        logo.anchorPoint = CGPoint(x: 0.5, y: 1)
        logo.position = CGPoint(x: screenWidth/2, y: screenHeight-30)
        addChild(logo)
        
        let omar = SKSpriteNode(imageNamed: omarImage)
        omar.anchorPoint = CGPoint(x: 0.5, y: 0)
        omar.position = CGPoint(x: screenWidth/2, y: 15)
        omar.zPosition = 10
        addChild(omar)
        
        let backButton = SKSpriteNode(imageNamed: backImage)
        backButton.zPosition = 10
        backButton.position = CGPoint(x: screenWidth/2, y: logo.position.y - 150)
        backButton.name = "backButton"
        addChild(backButton)
        
        let replayTutorialButton = SKSpriteNode(imageNamed: "replayTutorialButton")
        replayTutorialButton.zPosition = 3
        replayTutorialButton.position = CGPoint(x: self.view!.bounds.width/2, y: backButton.position.y - 80)
        replayTutorialButton.name = "replayTutorialButton"
        addChild(replayTutorialButton)
        
        let resetBestScoreButton = SKSpriteNode(imageNamed: "resetBestScoreButton")
        resetBestScoreButton.zPosition = 3
        resetBestScoreButton.position = CGPoint(x: self.view!.bounds.width/2, y: replayTutorialButton.position.y - 60)
        resetBestScoreButton.name = "resetBestScoreButton"
        addChild(resetBestScoreButton)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "resetBestScoreButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true), SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: true)]))
                }
                
                userDefaults.setInteger(0, forKey: "bestScore")
                userDefaults.setInteger(0, forKey: "currentScore")
                
                let alert = UIAlertView(title: "Reset Best Score",
                    message: "Your best score has been reset",
                    delegate: nil,
                    cancelButtonTitle: "OK")
                alert.show()
            }
            
            if nodeAtPoint(location).name == "backButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
                var gameScene = GameScene(size: self.size)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                let transition = SKTransition.pushWithDirection(.Right, duration: 0.5)
                self.scene!.view?.presentScene(gameScene, transition: transition)
            }
            
            if nodeAtPoint(location).name == "replayTutorialButton" {
                if userDefaults.boolForKey("gameSounds") == true {
                    self.runAction(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                }
          
                var tutorialScene = TutorialScene(size: self.size)
                tutorialScene.scaleMode = SKSceneScaleMode.AspectFill
                let transition = SKTransition.pushWithDirection(.Down, duration: 0.5)
                self.scene!.view?.presentScene(tutorialScene, transition: transition)
            }
        }
    }
    
}
