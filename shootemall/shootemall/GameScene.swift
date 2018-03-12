//
//  GameScene.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Enemy   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var player = SKSpriteNode()
    var gameVC: GameViewController?
    var scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    var enemiesDestroyed:Int = 0 {
        didSet {
            scoreLabel.text = "Kills: \(enemiesDestroyed)"
            if enemiesDestroyed == 10 {
                scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
            } else if enemiesDestroyed == 100 {
                scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
            } else if enemiesDestroyed == 1000 {
                scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
            } else if enemiesDestroyed == 10000 {
                scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        addBackgroundToScene()
        addPlayerToScene()
        startEnemyRunning()
        addScoreLabelToScene()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        let projectile = createProjectile()
        
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

// MARK: Physical Contacts
extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let
                projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(projectile: projectile, monster: monster)
            }
        }
        
    }
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        projectile.removeFromParent()
        monster.removeFromParent()
        
        enemiesDestroyed += 1
    }
}

// MARK: Add Nodes to Scene
extension GameScene {
    fileprivate func addBackgroundToScene() {
        let bgNode = SKSpriteNode(imageNamed: "background1")
        bgNode.color = UIColor.red
        bgNode.zPosition = -1
        bgNode.size = size
        bgNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(bgNode)
    }
    
    fileprivate func addPlayerToScene() {
        player = SKSpriteNode(imageNamed: "player1")
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        player.size = CGSize(width: size.width*0.22, height: size.width*0.22)
        addChild(player)
    }
    
    fileprivate func startEnemyRunning() {
        let enemyAdding = SKAction.run(addEnemy)
        let waitingTime = SKAction.wait(forDuration:  1.0)
        let sequence = SKAction.sequence([enemyAdding,waitingTime])
        
        run(sequence, completion: {
            self.startEnemyRunning()
        })
    }
    
    fileprivate func addEnemy() {
        let enemy = SKSpriteNode(imageNamed: "enemy1")
        enemy.color = UIColor.brown
        enemy.size = CGSize(width: size.width*0.14, height: size.width*0.14)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let xPosition = random(min: enemy.size.height/2, max: size.width - enemy.size.height/2)
        enemy.position = CGPoint(x: xPosition, y: size.height + enemy.size.width/2)
        addChild(enemy)
        
        let actionMove = SKAction.move(to: CGPoint(x: xPosition, y: -enemy.size.height), duration: TimeInterval(4))
        let actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.run() {
            self.view?.presentScene(nil)
            self.gameVC?.gameOver(score: self.enemiesDestroyed)
        }
        enemy.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    
    fileprivate func addScoreLabelToScene() {
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.black
        scoreLabel.text = "Kills: \(enemiesDestroyed)"
        scoreLabel.position = CGPoint(x: 4 + (scoreLabel.frame.width/2) , y: size.height * 0.9)
        addChild(scoreLabel)
    }
    
    fileprivate func createProjectile() -> SKSpriteNode {
        let projectile = SKSpriteNode(imageNamed: "projectile1")
        projectile.color = UIColor.yellow
        projectile.size = CGSize(width: size.width*0.08, height: size.width*0.08)
        projectile.position = player.position
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        return projectile
    }
}

// MARK: Math randomization Helper
extension GameScene {
    fileprivate func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    fileprivate func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}

