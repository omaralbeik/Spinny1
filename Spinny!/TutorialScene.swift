//
//  TutorialScene.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import MediaPlayer
import SpriteKit

var tutorialWheel = SKSpriteNode()


class TutorialScene: SKScene {
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.4)
        
        let rotateRightAction = SKAction.rotateByAngle(-CGFloat(360*(M_PI/180)), duration: 1.5)
        let rotateLeftAction = SKAction.rotateByAngle(CGFloat(360*(M_PI/180)), duration: 1.5)
        
        let fadeInAction = SKAction.fadeInWithDuration(1)
        let semiFadeInAction = SKAction.fadeAlphaTo(0.4, duration: 1)
        
        let wait1Action = SKAction.waitForDuration(1)
        let wait2Action = SKAction.waitForDuration(2)
        let wait3Action = SKAction.waitForDuration(3)
        let wait4Action = SKAction.waitForDuration(4)
        
        
        let fadeOutAction = SKAction.fadeOutWithDuration(1)
        
        let semiShow1Action = SKAction.sequence([semiFadeInAction, wait1Action, fadeOutAction])
        let semiShow2Action = SKAction.sequence([semiFadeInAction, wait2Action, fadeOutAction])
        let semiShow3Action = SKAction.sequence([semiFadeInAction, wait3Action, fadeOutAction])
        let semiShow4Action = SKAction.sequence([semiFadeInAction, wait4Action, fadeOutAction])
        
        
        let show1Action = SKAction.sequence([fadeInAction, wait1Action, fadeOutAction])
        let show2Action = SKAction.sequence([fadeInAction, wait2Action, fadeOutAction])
        let show3Action = SKAction.sequence([fadeInAction, wait3Action, fadeOutAction])
        let show4Action = SKAction.sequence([fadeInAction, wait4Action, fadeOutAction])
        
        let scaleUpAction = SKAction.scaleBy(1.05, duration: 0.5)
        let scaleDownAction = scaleUpAction.reversedAction()
        let popAction = SKAction.repeatAction(SKAction.sequence([scaleUpAction, scaleDownAction]), count: 2)
        
        let screenWidth = scene!.view!.bounds.width
        let screenHeight = scene!.view!.bounds.height
        
        backgroundColor = UIColor.whiteColor()
        let magicBackground = SKEmitterNode(fileNamed: "MagicParticle.sks")
        magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        magicBackground.zPosition = -1
        addChild(magicBackground)
        
        
        let cancelButton = SKSpriteNode(imageNamed: "cancelButton")
        cancelButton.zPosition = 10
        cancelButton.position = CGPoint(x: screenWidth - 35, y: screenHeight - 35)
        cancelButton.name = "cancelButton"
        addChild(cancelButton)
        
        tutorialWheel = SKSpriteNode(imageNamed: "wheel")
        tutorialWheel.size = CGSize(width: Double(screenHeight/4), height: Double(screenHeight/4))
        tutorialWheel.position = CGPoint(x: screenWidth/2, y: screenHeight/6)
        
        addChild(tutorialWheel)
        
        let wheelText = SKSpriteNode(imageNamed: "wheelText")
        wheelText.anchorPoint = CGPoint(x: 0, y: 0)
        wheelText.position = CGPoint(x: 30, y: tutorialWheel.position.y + tutorialWheel.size.height/2 + 10)
        wheelText.alpha = 0.01
        
        addChild(wheelText)
        
        wheelText.runAction(show1Action)
        wheelText.runAction(popAction)
        
        let leftHide = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.view!.bounds.width/2, height: self.view!.bounds.height))
        leftHide.zPosition = 5
        leftHide.position = CGPoint(x: self.view!.bounds.width/4, y: self.view!.bounds.height/2)
        leftHide.alpha = 0.01
        addChild(leftHide)
        
        leftHide.runAction(SKAction.sequence([wait3Action, semiShow4Action]))
        
        let rightThumb = SKSpriteNode(imageNamed: "thumbRight")
        rightThumb.zPosition = 10
        rightThumb.anchorPoint = CGPoint(x: 1, y: -30)
        rightThumb.position = CGPoint(x: self.view!.bounds.size.width, y: 0)
        rightThumb.alpha = 0.01
        addChild(rightThumb)
        
        rightThumb.runAction(SKAction.sequence([wait3Action, show1Action]))
        tutorialWheel.runAction(SKAction.sequence([wait4Action, rotateRightAction]))
        
        let touchRightText = SKSpriteNode(imageNamed: "touchRightText")
        touchRightText.anchorPoint = CGPoint(x: 1, y: 0)
        touchRightText.position = CGPoint(x: screenWidth - 25, y: tutorialWheel.position.y + tutorialWheel.size.height/2 + 50)
        touchRightText.alpha = 0.01
        addChild(touchRightText)
        
        touchRightText.runAction(SKAction.sequence([wait4Action, show2Action]))
        touchRightText.runAction(SKAction.sequence([wait4Action, popAction]))
        
        let rightHide = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.view!.bounds.width/2, height: self.view!.bounds.height))
        rightHide.zPosition = 5
        rightHide.position = CGPoint(x: self.view!.bounds.width * 0.75, y: self.view!.bounds.height/2)
        rightHide.alpha = 0.01
        addChild(rightHide)
        
        rightHide.runAction(SKAction.sequence([SKAction.waitForDuration(8), semiShow3Action]))
        
        let leftThumb = SKSpriteNode(imageNamed: "thumbLeft")
        leftThumb.zPosition = 10
        leftThumb.anchorPoint = CGPoint(x: 0, y: -30)
        leftThumb.position = CGPoint(x: 0, y: 0)
        leftThumb.alpha = 0.01
        addChild(leftThumb)
        
        leftThumb.runAction(SKAction.sequence([SKAction.waitForDuration(8), show1Action]))
        tutorialWheel.runAction(SKAction.sequence([SKAction.waitForDuration(9), rotateLeftAction]))
        
        let touchLeftText = SKSpriteNode(imageNamed: "touchLeftText")
        touchLeftText.anchorPoint = CGPoint(x: 0, y: 0)
        touchLeftText.position = CGPoint(x: 25, y: tutorialWheel.position.y + tutorialWheel.size.height/2 + 50)
        touchLeftText.alpha = 0.01
        addChild(touchLeftText)
        
        touchLeftText.runAction(SKAction.sequence([SKAction.waitForDuration(9), show2Action]))
        touchLeftText.runAction(SKAction.sequence([SKAction.waitForDuration(9), popAction]))
        
        
        let ballsFallText = SKSpriteNode(imageNamed: "ballsFallText")
        ballsFallText.anchorPoint = CGPoint(x: 0.5, y: 1)
        ballsFallText.position = CGPoint(x: screenWidth/2 , y: screenHeight - 40)
        ballsFallText.alpha = 0.01
        addChild(ballsFallText)
        
        let ball = Ball()
        ball.position = CGPoint(x: screenWidth/2, y: screenHeight + 30)
        
        
        ballsFallText.runAction(SKAction.sequence([SKAction.waitForDuration(13), show1Action]))
        ballsFallText.runAction(SKAction.sequence([SKAction.waitForDuration(13), popAction, wait1Action]), completion: { () -> Void in
            self.addChild(ball)
            ball.runAction(SKAction.sequence([wait2Action, SKAction.fadeOutWithDuration(1)]))
        })
        
        
        let matchText = SKSpriteNode(imageNamed: "matchText")
        matchText.anchorPoint = CGPoint(x: 0.5, y: 1)
        matchText.position = CGPoint(x: screenWidth/2, y: screenHeight - 60)
        matchText.alpha = 0.01
        addChild(matchText)
        
        matchText.runAction(SKAction.sequence([SKAction.waitForDuration(20), show2Action]))
        matchText.runAction(SKAction.sequence([SKAction.waitForDuration(20), SKAction.repeatAction(popAction, count: 2)]))
        
        let pointsText = SKSpriteNode(imageNamed: "pointsText")
        pointsText.anchorPoint = CGPoint(x: 0.5, y: 1)
        pointsText.position = CGPoint(x: screenWidth/2, y: screenHeight - 80)
        pointsText.alpha = 0.01
        addChild(pointsText)
        
        pointsText.runAction(SKAction.sequence([SKAction.waitForDuration(25),show3Action]))
        pointsText.runAction(SKAction.sequence([SKAction.waitForDuration(25),popAction]))
        
        let watchoutText = SKSpriteNode(imageNamed: "watchoutText")
        watchoutText.anchorPoint = CGPoint(x: 0.5, y: 1)
        watchoutText.position = CGPoint(x: screenWidth/2, y: screenHeight - 80)
        watchoutText.alpha = 0.01
        addChild(watchoutText)
        
        watchoutText.runAction(SKAction.sequence([SKAction.waitForDuration(30),show3Action]))
        watchoutText.runAction(SKAction.sequence([SKAction.waitForDuration(30),popAction]))
        
        let simpleText = SKSpriteNode(imageNamed: "simpleText")
        simpleText.anchorPoint = CGPoint(x: 0.5, y: 1)
        simpleText.position = CGPoint(x: screenWidth/2, y: screenHeight - 120)
        simpleText.alpha = 0.01
        addChild(simpleText)
        
        simpleText.runAction(SKAction.sequence([SKAction.waitForDuration(34), popAction]))
        simpleText.runAction(SKAction.sequence([SKAction.waitForDuration(34), show4Action]), completion: { () -> Void in
            let playText = SKSpriteNode(imageNamed: "playText")
            playText.anchorPoint = CGPoint(x: 0.5, y: 1)
            playText.position = CGPoint(x: screenWidth/2, y: screenHeight - 150)
            playText.alpha = 0.01
            self.addChild(playText)
            
            playText.runAction(SKAction.fadeInWithDuration(0.5))
            
            let lets = SKAction.sequence([SKAction.scaleBy(0.9, duration: 2), SKAction.group([SKAction.scaleBy(10, duration: 0.5), SKAction.fadeOutWithDuration(0.5)])])
            
            playText.runAction(lets, completion: { () -> Void in
                
                var gameScene = GameScene(size: self.size)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                let transition = SKTransition.pushWithDirection(.Up, duration: 1)
                self.scene!.view?.presentScene(gameScene, transition: transition)
            })
        })
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("TouchBegan")
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "cancelButton" {
                var gameScene = GameScene(size: self.size)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                let transition = SKTransition.pushWithDirection(.Up, duration: 0.5)
                self.scene!.view?.presentScene(gameScene, transition: transition)
            }
            
        }
    }
}