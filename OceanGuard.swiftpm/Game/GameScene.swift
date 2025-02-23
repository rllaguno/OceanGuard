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
    let boat = SKSpriteNode(imageNamed: "Boat")
    let motionManager = CMMotionManager()
    var appViewModel: AppViewModel?
    
    var timer: Timer?
    var timeRemaining: Int = 100
    var gearLevel: Int = 1
    var boatVelocity: CGFloat = 2
    var timerLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var gearLabel: SKLabelNode!
    
    let trashTypes = ["Bolsa CONAD", "Botella Aplastada", "Botella Torcida", "Lata"]
    let itemTypes = ["Battery Upgrade", "Gear Upgrade"]
    
    struct CollisionCategory {
        static let boat: UInt32 = 0x1 << 0 // 1
        static let trash: UInt32 = 0x1 << 1 // 2
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
        startDeviceMotion()
        startSpawningTrash()
        startSpawningItem()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.33, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeRemaining -= 1
        
        DispatchQueue.main.async {
            self.timerLabel.text = "\(self.timeRemaining)%"
        }
        
        if timeRemaining <= 0 {
            timer?.invalidate()
            appViewModel?.currentScreen = .endgame
        }
    }
    
    func startDeviceMotion() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
                guard let self = self, let data = data else { return }
                
                let tiltAngle = atan2(data.acceleration.y, data.acceleration.x) * 180 / .pi

                let deadZone = 175.0
                let maxAngle = 155.0
                let maxRotationSpeed: CGFloat = 0.04
                
                if abs(tiltAngle) < deadZone {
                    if abs(tiltAngle) <= maxAngle {
                        self.boat.zRotation -= maxRotationSpeed * (tiltAngle > 0 ? -1 : 1)
                    } else {
                        let normalizedAngle = (abs(tiltAngle) - deadZone) / (maxAngle - deadZone)
                        let rotationSpeed = maxRotationSpeed * CGFloat(normalizedAngle)
                        self.boat.zRotation -= rotationSpeed * (tiltAngle > 0 ? -1 : 1)
                    }
                }
            }
        }
    }
        
    func setupLabels() {
        let timerBackground = SKShapeNode(rectOf: CGSize(width: 300, height: 100), cornerRadius: 20)
        timerBackground.fillColor = .systemTeal.withAlphaComponent(0.4)
        timerBackground.position = CGPoint(x: size.width / 2 - 350, y: size.height - 70)
        timerBackground.zPosition = 100
        addChild(timerBackground)
        
        let timerImage = SKSpriteNode(imageNamed: "Battery")
        timerImage.position = CGPoint(x: size.width / 2 - 450, y: size.height - 70)
        timerImage.zPosition = 100
        timerImage.size = CGSize(width: 100, height: 100)
        timerImage.zRotation = CGFloat.pi / 2
        addChild(timerImage)
                
        timerLabel = SKLabelNode(text: "\(timeRemaining)%")
        timerLabel.fontSize = 80
        timerLabel.fontColor = .white
        timerLabel.fontName = "Futura"
        timerLabel.position = CGPoint(x: size.width / 2 - 310, y: size.height - 100)
        timerLabel.zPosition = 100
        addChild(timerLabel)
        
        let scoreBackground = SKShapeNode(rectOf: CGSize(width: 380, height: 100), cornerRadius: 20)
        scoreBackground.fillColor = .systemTeal.withAlphaComponent(0.4)
        scoreBackground.position = CGPoint(x: size.width / 2 + 15, y: size.height - 70)
        scoreBackground.zPosition = 100
        addChild(scoreBackground)
        
        scoreLabel = SKLabelNode(text: "\(appViewModel?.currentScore ?? 0) items")
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Futura"
        scoreLabel.position = CGPoint(x: size.width / 2 + 15, y: size.height - 100)
        scoreLabel.zPosition = 100
        addChild(scoreLabel)
        
        let gearBackground = SKShapeNode(rectOf: CGSize(width: 270, height: 100), cornerRadius: 20)
        gearBackground.fillColor = .systemTeal.withAlphaComponent(0.4)
        gearBackground.position = CGPoint(x: size.width / 2 + 365, y: size.height - 70)
        gearBackground.zPosition = 100
        addChild(gearBackground)
        
        let gearImage = SKSpriteNode(imageNamed: "Gear")
        gearImage.position = CGPoint(x: size.width / 2 + 445, y: size.height - 70)
        gearImage.zPosition = 100
        gearImage.size = CGSize(width: 100, height: 100)
        gearImage.zRotation = CGFloat.pi / 2
        addChild(gearImage)
                
        gearLabel = SKLabelNode(text: "Lv.\(gearLevel)")
        gearLabel.fontSize = 80
        gearLabel.fontColor = .white
        gearLabel.fontName = "Futura"
        gearLabel.position = CGPoint(x: size.width / 2 + 320, y: size.height - 100)
        gearLabel.zPosition = 100
        addChild(gearLabel)
    }
    
    func startSpawningTrash() {
        let spawnAction = SKAction.run { [weak self] in
            self?.spawnTrash()
        }
        let waitAction = SKAction.wait(forDuration: 0.05)
        let sequence = SKAction.sequence([spawnAction, waitAction])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
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
        
        trash.physicsBody = SKPhysicsBody(rectangleOf: trash.size)
        trash.physicsBody?.isDynamic = true
        trash.physicsBody?.affectedByGravity = false
        trash.physicsBody?.categoryBitMask = CollisionCategory.trash
        trash.physicsBody?.contactTestBitMask = CollisionCategory.boat
        trash.physicsBody?.collisionBitMask = 0
        
        let randomAngle = CGFloat.random(in: 0...(2 * .pi))
        let speed: CGFloat = 70.0
        let dx = cos(randomAngle) * speed
        let dy = sin(randomAngle) * speed
        trash.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        trash.zPosition = 10
        
        addChild(trash)
    }
    
    func startSpawningItem() {
        let spawnAction = SKAction.run { [weak self] in
            self?.spawnItem()
        }
        let waitAction = SKAction.wait(forDuration: 1.50)
        let sequence = SKAction.sequence([spawnAction, waitAction])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
    }
    
    func spawnItem() {
        let probability: Int = Int.random(in: 1...100)
        var itemType: Int = 0
        
        if probability < 30 {
            itemType = 1 //Gear Upgrade
        } else {
            itemType = 0 //Battery
        }
        
        let randomItem = itemTypes[itemType]
        
        let item = SKSpriteNode(imageNamed: randomItem)
        item.name = randomItem
        
        let spawnSide = Int.random(in: 0...3)
        switch spawnSide {
        case 0: // Top
            let randomX = CGFloat.random(in: 0...size.width)
            item.position = CGPoint(x: randomX, y: size.height + 50)
        case 1: // Right
            let randomY = CGFloat.random(in: 0...size.height)
            item.position = CGPoint(x: size.width + 50, y: randomY)
        case 2: // Bottom
            let randomX = CGFloat.random(in: 0...size.width)
            item.position = CGPoint(x: randomX, y: -50)
        default: // Left
            let randomY = CGFloat.random(in: 0...size.height)
            item.position = CGPoint(x: -50, y: randomY)
        }
        
        item.setScale(0.05)
        
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.isDynamic = true
        item.physicsBody?.affectedByGravity = false
        item.physicsBody?.categoryBitMask = CollisionCategory.trash
        item.physicsBody?.contactTestBitMask = CollisionCategory.boat
        item.physicsBody?.collisionBitMask = 0
        
        let randomAngle = CGFloat.random(in: 0...(2 * .pi))
        let speed: CGFloat = 70.0
        let dx = cos(randomAngle) * speed
        let dy = sin(randomAngle) * speed
        item.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        item.zPosition = 10
        
        addChild(item)
    }
    
    func increaseScore(name: String) {
        appViewModel?.currentScore += 1
        scoreLabel.text = "\(appViewModel?.currentScore ?? 0) \(appViewModel?.currentScore == 1 ? "item" : "items")"
        
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
    
    func increaseBattery() {
        if timeRemaining < 100 {
            timeRemaining += 5
        }
    }
    
    func upgradeGear() {
        if gearLevel < 7 {
            gearLevel += 1
            boatVelocity += 0.2
            gearLabel.text = "Lv.\(gearLevel)"
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
            
            let fadeOut = SKAction.fadeOut(withDuration: 0.1)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([fadeOut, remove])

            if trashNode.name == "Battery Upgrade" {
                increaseBattery()
            } else if trashNode.name == "Gear Upgrade" {
                upgradeGear()
            } else {
                increaseScore(name: trashNode.name!)
            }
            
            trashNode.run(sequence)
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let boatHalfWidth = boat.size.width / 2
        let boatHalfHeight = boat.size.height / 2
        
        let screenWidth = size.width
        let screenHeight = size.height
        
        if boat.position.x - boatHalfWidth < 0 {
            boat.position.x = boatHalfWidth
        } else if boat.position.x + boatHalfWidth > screenWidth {
            boat.position.x = screenWidth - boatHalfWidth
        }
        
        if boat.position.y - boatHalfHeight < 0 {
            boat.position.y = boatHalfHeight
        } else if boat.position.y + boatHalfHeight > screenHeight {
            boat.position.y = screenHeight - boatHalfHeight
        }
        
        let speed: CGFloat = boatVelocity
        
        let dx = cos(boat.zRotation) * speed
        let dy = sin(boat.zRotation) * speed
        
        boat.position.x += dx
        boat.position.y += dy
    }
}
