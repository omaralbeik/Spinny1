//
//  Physics.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit
import AudioToolbox

let gravity = CGVector(dx: 0, dy: -2)
var notificationSent = false

struct PhysicsCategory {
    
    static let None: UInt32          = 1
    
    static let RedBall: UInt32       = 2
    static let YellowBall: UInt32    = 4
    static let GreenBall: UInt32     = 8
    static let BlueBall: UInt32      = 16
    
    static let RedWheel: UInt32      = 32
    static let YellowWheel: UInt32   = 64
    static let GreenWheel: UInt32    = 128
    static let BlueWheel: UInt32     = 256
    
    static let BY: UInt32            = 512
    static let YR: UInt32            = 1024
    static let RG: UInt32            = 2048
    static let GB: UInt32            = 4096
    
}

let right = SKAction.moveByX(5, y: 0, duration: 0.02)
let left = SKAction.moveByX(-5, y: 0, duration: 0.02)
let shake = SKAction.sequence([right,left,left,right])

func handleContact(contact: SKPhysicsContact, scene: SKScene) {
    
    var ballBody: SKPhysicsBody
    var wheelBody: SKPhysicsBody
    
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        ballBody = contact.bodyA
        wheelBody = contact.bodyB
    } else {
        ballBody = contact.bodyB
        wheelBody = contact.bodyA
    }
    
    if score > bestScore {
        bestScore = score
    }
    
    // testing red balls
    if ballBody.categoryBitMask == PhysicsCategory.RedBall && (wheelBody.categoryBitMask == PhysicsCategory.RedWheel || wheelBody.categoryBitMask == PhysicsCategory.RG || wheelBody.categoryBitMask == PhysicsCategory.YR) {
        ballBody.categoryBitMask = PhysicsCategory.None
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            score++
            userDefaults.setInteger(bestScore, forKey: "currentScore")
            statusLabel.text = "+1"
            scoreLabel.text = "\(score)"
            ballBody.node?.removeFromParent()
            if userDefaults.boolForKey("gameSounds") == true {
                scene.runAction(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
            }
        })
    }
        
        // testing green balls
    else if ballBody.categoryBitMask == PhysicsCategory.GreenBall && (wheelBody.categoryBitMask == PhysicsCategory.GreenWheel || wheelBody.categoryBitMask == PhysicsCategory.GB || wheelBody.categoryBitMask == PhysicsCategory.RG) {
        ballBody.categoryBitMask = PhysicsCategory.None
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            score++
            userDefaults.setInteger(bestScore, forKey: "currentScore")
            statusLabel.text = "+1"
            scoreLabel.text = "\(score)"
            ballBody.node?.removeFromParent()
            if userDefaults.boolForKey("gameSounds") == true {
                scene.runAction(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
            }
        })
    }
        
        // testing yellow balls
    else if ballBody.categoryBitMask == PhysicsCategory.YellowBall && (wheelBody.categoryBitMask == PhysicsCategory.YellowWheel || wheelBody.categoryBitMask == PhysicsCategory.YR || wheelBody.categoryBitMask == PhysicsCategory.BY) {
        ballBody.categoryBitMask = PhysicsCategory.None
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            score++
            userDefaults.setInteger(bestScore, forKey: "currentScore")
            statusLabel.text = "+1"
            scoreLabel.text = "\(score)"
            ballBody.node?.removeFromParent()
            if userDefaults.boolForKey("gameSounds") == true {
                scene.runAction(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
            }
        })
    }
        
        // testing blue balls
    else if ballBody.categoryBitMask == PhysicsCategory.BlueBall && (wheelBody.categoryBitMask == PhysicsCategory.BlueWheel || wheelBody.categoryBitMask == PhysicsCategory.GB || wheelBody.categoryBitMask == PhysicsCategory.BY) {
        ballBody.categoryBitMask = PhysicsCategory.None
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            score++
            userDefaults.setInteger(bestScore, forKey: "currentScore")
            statusLabel.text = "+1"
            scoreLabel.text = "\(score)"
            ballBody.node?.removeFromParent()
            if userDefaults.boolForKey("gameSounds") == true {
                scene.runAction(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
            }
        })
    }
    else if ballBody.categoryBitMask == PhysicsCategory.None {
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            ballBody.node?.removeFromParent()
        })
    }
    else {
        ballBody.categoryBitMask = PhysicsCategory.None
        ballBody.node?.runAction(SKAction.fadeOutWithDuration(0.01), completion: { () -> Void in
            if userDefaults.boolForKey("gameSounds") == true {
                scene.runAction(SKAction.playSoundFileNamed("miss.mp3", waitForCompletion: true))
            }
            score -= 2
            statusLabel.text = "-2"
            scoreLabel.text = "\(score)"
            ballBody.node?.removeFromParent()

        })
    }
    
}
