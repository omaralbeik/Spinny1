//
//  Shared.swift
//  Spinny!
//
//  Created by Omar Albeik on 6/26/15.
//  Copyright (c) 2015 Omar Albeik. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit


var rightButtonTapped = false
var leftButtonTapped = false

var audioPlayer = AVAudioPlayer()
let userDefaults = NSUserDefaults.standardUserDefaults()
let notificationCenter = NSNotificationCenter.defaultCenter()


struct Colors {
    static let blueColor = UIColor(netHex: 0x34B5E6)
    static let redColor = UIColor(netHex: 0xFF6C6C)
    static let greenColor = UIColor(netHex: 0x0CC7B4)
    static let yellowColor = UIColor(netHex: 0xFED830)
    static let grayColor = UIColor(netHex: 0x3D3D3D)
}

func playMusic() {
    var music = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
    AVAudioSession.sharedInstance().setActive(true, error: nil)
    var error: NSError?
    audioPlayer = AVAudioPlayer(contentsOfURL: music, error: &error)
    audioPlayer.prepareToPlay()
    audioPlayer.numberOfLoops = -1
}

func count (scene: SKScene) {
    
    if userDefaults.boolForKey("gameSounds") == true {
        scene.runAction(SKAction.playSoundFileNamed("count.mp3", waitForCompletion: false))
    }
    
    let countLabel3 = SKLabelNode(text: "3")
    countLabel3.fontSize = 600
    countLabel3.fontColor = Colors.redColor
    countLabel3.position = CGPoint(x: scene.view!.bounds.size.width/2, y: scene.view!.bounds.size.height/2)
    scene.addChild(countLabel3)
    countLabel3.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.6))
    countLabel3.runAction(SKAction.scaleTo(0, duration: 0.6), completion: { () -> Void in
        countLabel3.removeFromParent()
        
        let countLabel2 = SKLabelNode(text: "2")
        countLabel2.fontSize = 600
        countLabel2.fontColor = Colors.yellowColor
        countLabel2.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.6))
        countLabel2.position = CGPoint(x: scene.view!.bounds.size.width/2, y: scene.view!.bounds.size.height/2)
        scene.addChild(countLabel2)
        
        countLabel2.runAction(SKAction.scaleTo(0, duration: 0.6), completion: { () -> Void in
            countLabel2.removeFromParent()
            
            let countLabel1 = SKLabelNode(text: "1")
            countLabel1.fontSize = 600
            countLabel1.fontColor = Colors.greenColor
            countLabel1.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.6))
            countLabel1.position = CGPoint(x: scene.view!.bounds.size.width/2, y: scene.view!.bounds.size.height/2)
            scene.addChild(countLabel1)
            
            countLabel1.runAction(SKAction.scaleTo(0, duration: 0.6), completion: { () -> Void in
                countLabel1.removeFromParent()
            })
        })
    })
}