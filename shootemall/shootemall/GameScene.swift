//
//  GameScene.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    var monstersDestroyed:Int = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        
        // Add Background
        let bgNode = SKSpriteNode()
        bgNode.color = UIColor.red
        bgNode.zPosition = -1
        bgNode.size = size
        bgNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(bgNode)
        
        // Add a player
        let player = SKSpriteNode()
        player.color = UIColor.black
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        player.size = CGSize(width: size.width*0.22, height: size.width*0.22)
        addChild(player)
        
        // Add Score Label
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.black
        scoreLabel.text = "Kills: \(monstersDestroyed)"
        scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
        addChild(scoreLabel)
    }
}

