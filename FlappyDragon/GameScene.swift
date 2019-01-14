//
//  GameScene.swift
//  FlappyDragon
//
//  Created by Matheus Lima on 13/01/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import SpriteKit
import GameplayKit

// TODO: Refactor to MVC Pattern

class GameScene: SKScene {
    
    var floor: SKSpriteNode!
    var player: SKSpriteNode!
    var intro: SKSpriteNode!
    var gameArea: CGFloat = 410.0
    var velocity: Double = 100.0
    var gameFinished = false
    var gameStarted = false
    var restart = false
    var scoreLabel: SKLabelNode!
    var score: Int = 0
    var flyForce: CGFloat = 30.0
    
    override func didMove(to view: SKView) {
        addBackground()
        addFloor()
        addIntro()
        addPlayer()
        movePlayer()
        moveFloor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted {
                startGame()
            } else {
                player.physicsBody?.velocity = CGVector.zero
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if gameStarted {
            let yVelocity = player.physicsBody!.velocity.dy * 0.001 as CGFloat
            player.zRotation = yVelocity
        }
    }
    
    func startGame() {
        intro.removeFromParent()
        addScore()
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2 - 10)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
        
        gameStarted = true
    }
}

// MARK: ADD Functions
extension GameScene {
    func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        /* Center */
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        
        addChild(background)
    }
    
    func addFloor() {
        floor = SKSpriteNode(imageNamed: "floor")
        floor.zPosition = 2
        floor.position = CGPoint(x: floor.size.width / 2, y: size.height - gameArea - floor.size.height / 2)
        
        addChild(floor)
        
        let invisibleFloor = SKNode()
        invisibleFloor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 1))
        invisibleFloor.physicsBody?.isDynamic = false
        invisibleFloor.position = CGPoint(x: size.width / 2, y: size.height - gameArea)
        invisibleFloor.zPosition = 2
        
        addChild(invisibleFloor)
        
        let invisibleRoof = SKNode()
        invisibleRoof.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 1))
        invisibleRoof.physicsBody?.isDynamic = false
        invisibleRoof.position = CGPoint(x: size.width / 2, y: size.height)
        invisibleRoof.zPosition = 2
        
        addChild(invisibleRoof)
    }
    
    func addIntro() {
        intro = SKSpriteNode(imageNamed: "intro")
        intro.zPosition = 3
        intro.position = CGPoint(x: size.width / 2, y: size.height - 210)
        
        addChild(intro)
    }
    
    func addPlayer() {
        player = SKSpriteNode(imageNamed: "player1")
        player.zPosition = 4
        player.position = CGPoint(x: 60, y: size.height - gameArea / 2)
        
        addChild(player)
    }
    
    func addScore() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 94
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 5
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 100)
        scoreLabel.alpha = 0.8
        
        addChild(scoreLabel)
    }
}

// MARK: Movement Functions
extension GameScene {
    func movePlayer() {
        /* Create textures */
        var playerTextures = [SKTexture]()
        for i in 1...4 {
            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
        }
        
        /* Animate dragon */
        let animationAction = SKAction.animate(with: playerTextures, timePerFrame: 0.09)
        let repeatAction = SKAction.repeatForever(animationAction)
        
        player.run(repeatAction)
    }
    
    func moveFloor() {
        let duration = Double(floor.size.width / 2) / velocity
        /* Create movement */
        let moveFloorAction = SKAction.moveBy(x: -floor.size.width / 2, y: 0, duration: duration)
        let resetXAction = SKAction.moveBy(x: floor.size.width / 2, y: 0, duration: 0)
        
        /* Create Actions */
        let sequenceAction = SKAction.sequence([moveFloorAction, resetXAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        /* Run */
        floor.run(repeatAction)
    }
}
