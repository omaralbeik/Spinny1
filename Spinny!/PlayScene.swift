//
//  PlayScene.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit
import AudioToolbox

var score: Int = 1
var bestScore = 1

var statusLabel = SKLabelNode()
var scoreLabel = SKLabelNode()
var wheel = SKSpriteNode()
var timer = NSTimer()
var wheelSpeed = CGFloat()
var ballStartingPoint = CGPoint()
var wheelShaked = false


class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMoveToView(view: SKView) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        wheelShaked = false
        
        count(self)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = gravity
        
        let screenWidth = scene!.view!.bounds.width
        let screenHeight = scene!.view!.bounds.height
        
        ballStartingPoint = CGPoint(x: screenWidth/2, y: screenHeight + 20)
        
        
        if userDefaults.boolForKey("darkMode") == true {
            backgroundColor = Colors.grayColor
            let magicBackground = SKEmitterNode(fileNamed: "MagicDarkParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
        } else {
            backgroundColor = UIColor.whiteColor()
            let magicBackground = SKEmitterNode(fileNamed: "MagicParticle.sks")
            magicBackground.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
            magicBackground.zPosition = -1
            addChild(magicBackground)
        }
        
        score = 1
        bestScore = 1
        userDefaults.setInteger(bestScore, forKey: "currentScore")
        
        wheel = Wheel.addWheel(self, size: Double(screenHeight/4))
        wheel.position = CGPoint(x: screenWidth/2, y: screenHeight/6)
        wheelSpeed = 20
        wheel.runAction(Wheel.rotateWheel(.Right))
        
        statusLabel = SKLabelNode()
        statusLabel.fontColor = Colors.blueColor
        statusLabel.alpha = 0.3
        statusLabel.text = ""
        statusLabel.fontSize = 150
        statusLabel.zPosition = 10
        statusLabel.horizontalAlignmentMode = .Center
        statusLabel.verticalAlignmentMode = .Center
        statusLabel.position = CGPoint(x: wheel.position.x, y: wheel.position.y + 160)
        addChild(statusLabel)
        
        scoreLabel = SKLabelNode()
        
        if userDefaults.boolForKey("darkMode") == true {
            scoreLabel.fontColor = UIColor.whiteColor()
        } else {
            scoreLabel.fontColor = UIColor.darkGrayColor()
        }
        
        scoreLabel.text = ""
        scoreLabel.fontSize = 40
        //        scoreLabel.fontName = "HelveticaNeue-Thin"
        scoreLabel.zPosition = 10
        scoreLabel.horizontalAlignmentMode = .Center
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.position = CGPoint(x: screenWidth/2, y: screenHeight - 60)
        addChild(scoreLabel)
        
    }
    
    func onTimer() {
        timer.invalidate()
        println(score)
        let ball = Ball()
        ball.position = ballStartingPoint
        addChild(ball)
        
        var timeInterval = timer.timeInterval
        if timer.timeInterval > 1 {
            timeInterval = timer.timeInterval - timer.timeInterval/40
            wheelSpeed += 0.5
        } else if timer.timeInterval > 0.5 {
            timeInterval = timer.timeInterval - timer.timeInterval/80
            wheelSpeed += 0.2
        } else {
            timeInterval = timer.timeInterval - timer.timeInterval/250
            wheelSpeed += 0.1
        }
        println(timeInterval)
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        if score < 0 {
            
            if wheelShaked == false {
                wheelShaked = true
                scoreLabel.text = "Game Over"
                timer.invalidate()
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                if userDefaults.boolForKey("gameSounds") == true {
                    println("gameOver")
                    self.runAction(SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: true))
                }
                wheel.runAction(SKAction.repeatAction(shake, count: 3), completion: { () -> Void in
                    var gameScene = GameScene(size: self.size)
                    gameScene.scaleMode = SKSceneScaleMode.AspectFill
                    self.scene!.view?.presentScene(gameScene)
                })
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        handleContact(contact, self)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if location.x <= self.view!.bounds.size.width/2 {
                leftButtonTapped = false
                if rightButtonTapped == false {
                    wheel.removeAllActions()
                    wheel.runAction(Wheel.rotateWheel(.Left))
                    rightButtonTapped = true
                }
                wheel.speed = wheelSpeed
            }
            if location.x >= self.view!.bounds.size.width/2 {
                
                rightButtonTapped = false
                if rightButtonTapped == false {
                    wheel.removeAllActions()
                    wheel.runAction(Wheel.rotateWheel(.Right))
                    leftButtonTapped = true
                }
                wheel.speed = wheelSpeed
            }
        }
        
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if location.x <= self.view!.bounds.size.width/2 {
                leftButtonTapped = false
                if rightButtonTapped == false {
                    wheel.removeAllActions()
                    wheel.runAction(Wheel.rotateWheel(.Left))
                    rightButtonTapped = true
                }
                wheel.speed = wheelSpeed
            }
            if location.x >= self.view!.bounds.size.width/2 {
                rightButtonTapped = false
                if leftButtonTapped == false {
                    wheel.removeAllActions()
                    wheel.runAction(Wheel.rotateWheel(.Right))
                    leftButtonTapped = true
                }
                wheel.speed = wheelSpeed
            }
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        wheel.speed = 1
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        wheel.speed = 1
    }
}
