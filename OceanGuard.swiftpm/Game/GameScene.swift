//
//  File.swift
//  OceanGuard
//
//  Created by Rodrigo Llaguno on 22/02/25.
//

import SpriteKit
import CoreMotion
import SwiftUI

class GameScene: SKScene, @preconcurrency SKPhysicsContactDelegate {
    let boat = SKSpriteNode(imageNamed: "Boat") // Boat sprite
    let motionManager = CMMotionManager()
    var appViewModel: AppViewModel? // Store reference to ViewModel
    
    var timer: Timer?
    var timeRemaining: Int = 30
    var timerLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    
    let trashTypes = ["Bolsa CONAD", "Botella Aplastada", "Botella Torcida", "Lata"]
    
    struct CollisionCategory {
        static let boat: UInt32 = 0x1 << 0     // 1
        static let trash: UInt32 = 0x1 << 1    // 2
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .blue
        physicsWorld.contactDelegate = self
        
        let ocean = SKSpriteNode(imageNamed: "Ocean")
        ocean.position = CGPoint(x: size.width / 2, y: size.height / 2)
        ocean.zPosition = -1
        addChild(ocean)
        
        boat.setScale(0.2)
        boat.position = CGPoint(x: size.width / 2, y: size.height / 2)
        boat.physicsBody = SKPhysicsBody(circleOfRadius: boat.size.width / 2)
        boat.physicsBody?.isDynamic = false
        boat.physicsBody?.categoryBitMask = 1
        boat.physicsBody?.contactTestBitMask = 2
        boat.physicsBody?.collisionBitMask = 0
        addChild(boat)
        
        setupLabels()
        startTimer()
        startGyroscope()
        startSpawningTrash()

    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeRemaining -= 1
        
        DispatchQueue.main.async {
            self.timerLabel.text = "\(self.timeRemaining)"
        }
        
        if timeRemaining <= 0 {
            timer?.invalidate()
            appViewModel?.currentScreen = .endgame
        }
    }
    
    func startGyroscope() {
        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates(to: .main) { [weak self] data, _ in
                guard let self = self, let data = data else { return }
                
                // Get the Z-axis rotation rate from the gyroscope
                let rotationRate = data.rotationRate.z  // Left/Right tilt (Z-axis)
                
                // Rotate the boat continuously when the iPad is tilted
                if rotationRate > 0.020 || rotationRate < -0.020 {
                    let rotationSpeed: CGFloat = 0.03
                    if rotationRate > 0 {
                        self.boat.zRotation += rotationSpeed  // Rotate right
                    } else {
                        self.boat.zRotation -= rotationSpeed  // Rotate left
                    }
                }
            }
        }
    }
    
    func startSpawningTrash() {
        let spawnAction = SKAction.run { [weak self] in
            self?.spawnTrash()
        }
        let waitAction = SKAction.wait(forDuration: 0.05) // Spawns trash every 2 seconds
        let sequence = SKAction.sequence([spawnAction, waitAction])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
    }
    
    func setupLabels() {
        let timerBackground = SKShapeNode(rectOf: CGSize(width: 120, height: 100), cornerRadius: 20)
        timerBackground.fillColor = .white.withAlphaComponent(0.4)
        timerBackground.position = CGPoint(x: size.width / 2 - 150, y: size.height - 70)
        timerBackground.zPosition = 100
        addChild(timerBackground)
        
        timerLabel = SKLabelNode(text: "\(timeRemaining)")
        timerLabel.fontSize = 80
        timerLabel.fontColor = .black
        timerLabel.fontName = "Futura"
        timerLabel.position = CGPoint(x: size.width / 2 - 150, y: size.height - 100)
        timerLabel.zPosition = 100
        addChild(timerLabel)
        
        let scoreBackground = SKShapeNode(rectOf: CGSize(width: 340, height: 100), cornerRadius: 20)
        scoreBackground.fillColor = .white.withAlphaComponent(0.4)
        scoreBackground.position = CGPoint(x: size.width / 2 + 100, y: size.height - 70)
        scoreBackground.zPosition = 100
        addChild(scoreBackground)
        
        scoreLabel = SKLabelNode(text: "Score: \(appViewModel?.currentScore ?? 0)")
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Futura"
        scoreLabel.position = CGPoint(x: size.width / 2 + 100, y: size.height - 100)
        scoreLabel.zPosition = 100
        addChild(scoreLabel)
        
    }
    
    func spawnTrash() {
        guard let randomTrash = trashTypes.randomElement() else { return }
        
        let trash = SKSpriteNode(imageNamed: randomTrash)
        trash.name = randomTrash

        let spawnSide = Int.random(in: 0...3)
        switch spawnSide {
        case 0: // Top
            let randomX = CGFloat.random(in: 0...size.width)
            trash.position = CGPoint(x: randomX, y: size.height + 50)
        case 1: // Right
            let randomY = CGFloat.random(in: 0...size.height)
            trash.position = CGPoint(x: size.width + 50, y: randomY)
        case 2: // Bottom
            let randomX = CGFloat.random(in: 0...size.width)
            trash.position = CGPoint(x: randomX, y: -50)
        default: // Left
            let randomY = CGFloat.random(in: 0...size.height)
            trash.position = CGPoint(x: -50, y: randomY)
        }

        trash.setScale(0.05)
        
        // trash physics
        trash.physicsBody = SKPhysicsBody(rectangleOf: trash.size)
        trash.physicsBody?.isDynamic = true
        trash.physicsBody?.affectedByGravity = false
        trash.physicsBody?.categoryBitMask = CollisionCategory.trash
        trash.physicsBody?.contactTestBitMask = CollisionCategory.boat
        trash.physicsBody?.collisionBitMask = 0
        
        // trash movement
        let randomAngle = CGFloat.random(in: 0...(2 * .pi))
        let speed: CGFloat = 70.0
        let dx = cos(randomAngle) * speed
        let dy = sin(randomAngle) * speed
        trash.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        trash.zPosition = 10
        
        addChild(trash)
    }
    
    func increaseScore(name: String) {
        appViewModel?.currentScore += 1
        scoreLabel.text = "Score: \(appViewModel?.currentScore ?? 0)"
        
        if name == "Bolsa CONAD" {
            appViewModel?.currentOrangeBags += 1
        } else if name == "Lata" {
            appViewModel?.currentRedCans += 1
        } else if name == "Botella Aplastada" {
            appViewModel?.currentGreenBottles += 1
        } else {
            appViewModel?.currentBlueBottles += 1
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == (CollisionCategory.boat | CollisionCategory.trash) {
            let trashNode: SKNode
            if contact.bodyA.categoryBitMask == CollisionCategory.trash {
                trashNode = contact.bodyA.node!
            } else {
                trashNode = contact.bodyB.node!
            }
            
            // Remove the trash with a fade-out animation
            let fadeOut = SKAction.fadeOut(withDuration: 0.1)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeOut, remove])

            increaseScore(name: trashNode.name!)
            
            trashNode.run(sequence)
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Ensure boat stays within screen boundaries
        let boatHalfWidth = boat.size.width / 2
        let boatHalfHeight = boat.size.height / 2
        
        // Screen boundaries
        let screenWidth = size.width
        let screenHeight = size.height
        
        // Check if boat is out of bounds and adjust position if needed
        if boat.position.x - boatHalfWidth < 0 {
            boat.position.x = boatHalfWidth // Prevent boat from going left
        } else if boat.position.x + boatHalfWidth > screenWidth {
            boat.position.x = screenWidth - boatHalfWidth // Prevent boat from going right
        }
        
        if boat.position.y - boatHalfHeight < 0 {
            boat.position.y = boatHalfHeight // Prevent boat from going down
        } else if boat.position.y + boatHalfHeight > screenHeight {
            boat.position.y = screenHeight - boatHalfHeight // Prevent boat from going up
        }
        
        // Move the boat in the direction it's facing
        let speed: CGFloat = 2  // Movement speed
        
        // Calculate movement in the direction of the boat's rotation
        let dx = cos(boat.zRotation) * speed
        let dy = sin(boat.zRotation) * speed
        
        // Update the boat's position
        boat.position.x += dx
        boat.position.y += dy
    }
}
