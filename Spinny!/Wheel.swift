//
//  Wheel.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/25/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import SpriteKit

struct WheelConstants {
    static var WheelActiveSpeed: CGFloat = 18
    static let CompleteTurn = CGFloat(360*(M_PI/180))
    static let WheelCompleteTurnPeriod = Double(25)
}

enum Side {
    case Right
    case Left
}

var wheelSize: Double?

class Wheel: SKSpriteNode {
    
    class func addWheel(scene: SKScene, size: Double) -> SKSpriteNode {
        
        var wheel = SKSpriteNode()
        
        let wheelYPos: CGFloat = 100
        
        if userDefaults.boolForKey("accMode") == true {
            wheel = SKSpriteNode(imageNamed: "wheelAcc")
        } else {
            wheel = SKSpriteNode(imageNamed: "wheel")

        }

        wheel.size = CGSize(width: size, height: size)
        wheel.zPosition = 6
        wheel.position = CGPointMake(scene.view!.bounds.width/2, wheelYPos)
        
        let yellowWheel = SKSpriteNode()
        yellowWheel.position = CGPoint(x: wheel.size.width/4, y: wheel.size.width/4)
        yellowWheel.zPosition = 4
        yellowWheel.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "yellowWheel4"), size: CGSize(width: CGFloat(size/2), height: CGFloat(size/2)))
        yellowWheel.physicsBody!.dynamic = false
        yellowWheel.physicsBody!.categoryBitMask = PhysicsCategory.YellowWheel
        yellowWheel.physicsBody?.collisionBitMask = PhysicsCategory.None
        yellowWheel.physicsBody!.restitution = 0
        yellowWheel.name = "yellowWheel"
        
        let redWheel = SKSpriteNode()
        redWheel.position = CGPoint(x: -wheel.size.width/4, y: wheel.size.width/4)
        redWheel.zPosition = 4
        redWheel.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "redWheel4"), size: CGSize(width: CGFloat(size/2), height: CGFloat(size/2)))
        redWheel.physicsBody!.dynamic = false
        redWheel.physicsBody!.categoryBitMask = PhysicsCategory.RedWheel
        redWheel.physicsBody?.collisionBitMask = PhysicsCategory.None
        redWheel.physicsBody!.restitution = 0
        redWheel.name = "redWheel"
        
        let greenWheel = SKSpriteNode()
        greenWheel.position = CGPoint(x: -wheel.size.width/4, y: -wheel.size.width/4)
        greenWheel.zPosition = 4
        greenWheel.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "greenWheel4"), size: CGSize(width: CGFloat(size/2), height: CGFloat(size/2)))
        greenWheel.physicsBody!.dynamic = false
        greenWheel.physicsBody!.categoryBitMask = PhysicsCategory.GreenWheel
        greenWheel.physicsBody?.collisionBitMask = PhysicsCategory.None
        greenWheel.physicsBody!.restitution = 0
        greenWheel.name = "greenWheel"
        
        let blueWheel = SKSpriteNode()
        blueWheel.position = CGPoint(x: wheel.size.width/4, y: -wheel.size.width/4)
        blueWheel.zPosition = 4
        blueWheel.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "blueWheel4"), size: CGSize(width: CGFloat(size/2), height: CGFloat(size/2)))
        blueWheel.physicsBody!.dynamic = false
        blueWheel.physicsBody!.categoryBitMask = PhysicsCategory.BlueWheel
        blueWheel.physicsBody?.collisionBitMask = PhysicsCategory.None
        blueWheel.physicsBody!.restitution = 0
        blueWheel.name = "blueWheel"
        
        let by = SKSpriteNode()
        by.position = CGPoint(x: wheel.size.width/4, y: 0)
        by.zPosition = 4
        by.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "by4"), size: CGSize(width: wheel.size.width/2 + 5, height: wheel.size.width/3))
        by.physicsBody!.dynamic = false
        by.physicsBody!.categoryBitMask = PhysicsCategory.BY
        by.physicsBody?.collisionBitMask = PhysicsCategory.None
        by.physicsBody!.restitution = 0
        by.name = "by"
        
        let yr = SKSpriteNode()
        yr.position = CGPoint(x: 0, y: wheel.size.height/4)
        yr.zPosition = 4
        yr.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "yr4"), size: CGSize(width: wheel.size.width/3 , height: wheel.size.width/2 + 5))
        yr.physicsBody!.dynamic = false
        yr.physicsBody!.categoryBitMask = PhysicsCategory.YR
        yr.physicsBody?.collisionBitMask = PhysicsCategory.None
        yr.physicsBody!.restitution = 0
        yr.name = "yr"
        
        let rg = SKSpriteNode()
        rg.position = CGPoint(x: -wheel.size.width/4, y: 0)
        rg.zPosition = 4
        rg.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "rg4"), size: CGSize(width: wheel.size.width/2 + 5, height: wheel.size.width/3))
        rg.physicsBody!.dynamic = false
        rg.physicsBody!.categoryBitMask = PhysicsCategory.RG
        rg.physicsBody?.collisionBitMask = PhysicsCategory.None
        rg.physicsBody!.restitution = 0
        rg.name = "rg"
        
        let gb = SKSpriteNode()
        gb.position = CGPoint(x: 0, y: -wheel.size.height/4)
        gb.zPosition = 4
        gb.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "gb4"), size: CGSize(width: wheel.size.width/3 , height: wheel.size.width/2 + 5))
        gb.physicsBody!.dynamic = false
        gb.physicsBody!.categoryBitMask = PhysicsCategory.GB
        gb.physicsBody?.collisionBitMask = PhysicsCategory.None
        gb.physicsBody!.restitution = 0
        gb.name = "gb"
        
        wheelSize = size
        
        wheel.addChild(blueWheel)
        wheel.addChild(yellowWheel)
        wheel.addChild(redWheel)
        wheel.addChild(greenWheel)
        
        wheel.addChild(by)
        wheel.addChild(yr)
        wheel.addChild(rg)
        wheel.addChild(gb)
        
        scene.addChild(wheel)
        return wheel
    }
    
    class func rotateWheel(side: Side) -> SKAction {
        var turnFactor: CGFloat?
        switch side {
        case .Left: turnFactor = 1
        case .Right: turnFactor = -1
        }
        let rotate = SKAction.rotateByAngle(turnFactor! * WheelConstants.CompleteTurn, duration: WheelConstants.WheelCompleteTurnPeriod)
        let rotateForEver = SKAction.repeatActionForever(rotate)
        return rotateForEver
    }
    
}