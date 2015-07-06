//
//  Ball.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit

enum BallType {
    case Blue
    case Green
    case Yellow
    case Red
}

class Ball: SKNode {
    
    var ballSprite = SKSpriteNode()
    var ballFire = SKEmitterNode()
    var ballSpriteType = BallType.Blue
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        let diceRoll = arc4random_uniform(4)
        
        switch diceRoll {
        case 0:
            if userDefaults.boolForKey("accMode") == true {
                ballSprite = SKSpriteNode(imageNamed: "blueBallAcc")
            } else {
                ballSprite = SKSpriteNode(imageNamed: "blueBall")
            }
            ballFire = SKEmitterNode(fileNamed: "BlueParticle.sks")
            ballSpriteType = .Blue
            
        case 1:
            if userDefaults.boolForKey("accMode") == true {
                ballSprite = SKSpriteNode(imageNamed: "redBallAcc")
            } else {
                ballSprite = SKSpriteNode(imageNamed: "redBall")
            }
            ballFire = SKEmitterNode(fileNamed: "RedParticle.sks")
            ballSpriteType = .Red
            
        case 2:
            if userDefaults.boolForKey("accMode") == true {
                ballSprite = SKSpriteNode(imageNamed: "greenBallAcc")
            } else {
                ballSprite = SKSpriteNode(imageNamed: "greenBall")
            }
            ballFire = SKEmitterNode(fileNamed: "GreenParticle.sks")
            ballSpriteType = .Green
            
        case 3:
            if userDefaults.boolForKey("accMode") == true {
                ballSprite = SKSpriteNode(imageNamed: "yellowBallAcc")
            } else {
                ballSprite = SKSpriteNode(imageNamed: "yellowBall")
            }
            ballFire = SKEmitterNode(fileNamed: "YellowParticle.sks")
            ballSpriteType = .Yellow
            
        default: break
        }
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballSprite.size.width/2 - 3)
        
        switch ballSpriteType {
        case .Blue:
            self.physicsBody!.categoryBitMask = PhysicsCategory.BlueBall
            statusLabel.fontColor = Colors.blueColor
            statusLabel.runAction(SKAction.fadeAlphaTo(1, duration: 0.3), completion: { () -> Void in
                statusLabel.runAction(SKAction.fadeAlphaTo(0.01, duration: 0.5))
            })
            
        case .Green:
            self.physicsBody!.categoryBitMask = PhysicsCategory.GreenBall
            statusLabel.fontColor = Colors.greenColor
            statusLabel.runAction(SKAction.fadeAlphaTo(1, duration: 0.3), completion: { () -> Void in
                statusLabel.runAction(SKAction.fadeAlphaTo(0.01, duration: 0.5))
            })
            
        case .Red:
            self.physicsBody!.categoryBitMask = PhysicsCategory.RedBall
            statusLabel.fontColor = Colors.redColor
            statusLabel.runAction(SKAction.fadeAlphaTo(1, duration: 0.3), completion: { () -> Void in
                statusLabel.runAction(SKAction.fadeAlphaTo(0.01, duration: 0.5))
            })
            
        case .Yellow:
            self.physicsBody!.categoryBitMask = PhysicsCategory.YellowBall
            statusLabel.fontColor = Colors.yellowColor
            statusLabel.runAction(SKAction.fadeAlphaTo(1, duration: 0.3), completion: { () -> Void in
                statusLabel.runAction(SKAction.fadeAlphaTo(0.01, duration: 0.5))
            })
            
        }
        self.physicsBody!.contactTestBitMask = PhysicsCategory.RedWheel | PhysicsCategory.GreenWheel | PhysicsCategory.YellowWheel | PhysicsCategory.BlueWheel | PhysicsCategory.YR | PhysicsCategory.RG | PhysicsCategory.BY | PhysicsCategory.GB
        
        self.physicsBody!.dynamic = true
        //        ballSprite.physicsBody!.affectedByGravity = false
        self.physicsBody!.restitution = 0
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.collisionBitMask = 0
        
        ballFire.position = CGPoint(x: 0, y: 10)
        ballFire.zPosition = ballSprite.zPosition-1
        ballSprite.addChild(ballFire)
        
        self.addChild(ballSprite)
    }
    
}
