//
//  GameScene.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var player = SKSpriteNode()
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
        player.color = UIColor.black
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        player.size = CGSize(width: size.width*0.22, height: size.width*0.22)
        addChild(player)
        
        // Add Monsters running in
        startMonsterRunning()
        
        // Add Score Label
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.black
        scoreLabel.text = "Kills: \(monstersDestroyed)"
        scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
        addChild(scoreLabel)
    }
    
    fileprivate func startMonsterRunning() {
        let monsterAdding = SKAction.run(addMonster)
        let waitingTime = SKAction.wait(forDuration:  1.0)
        let sequence = SKAction.sequence([monsterAdding,waitingTime])
        
        run(sequence, completion: {
            self.startMonsterRunning()
        })
    }
    
    fileprivate func addMonster() {
        let monster = SKSpriteNode()
        monster.color = UIColor.brown
        monster.size = CGSize(width: size.width*0.14, height: size.width*0.14)
        
        let xPosition = random(min: monster.size.height/2, max: size.width - monster.size.height/2)
        monster.position = CGPoint(x: xPosition, y: size.height + monster.size.width/2)
        addChild(monster)
        
        let actionMove = SKAction.move(to: CGPoint(x: xPosition, y: -monster.size.height), duration: TimeInterval(4))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        let projectile = SKSpriteNode()
        projectile.color = UIColor.yellow
        projectile.size = CGSize(width: size.width*0.08, height: size.width*0.08)
        projectile.position = player.position
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        
        let offset = touchLocation.substract(by: projectile.position)
        if (offset.y < 0) { return }
        
        addChild(projectile)
        
        let direction = offset.normalized()
        let shootAmount = direction.multiply(by: 1000)
        let realDest = shootAmount.add(point: projectile.position)
        
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}

// Random math
extension GameScene {
    fileprivate func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    fileprivate func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}

