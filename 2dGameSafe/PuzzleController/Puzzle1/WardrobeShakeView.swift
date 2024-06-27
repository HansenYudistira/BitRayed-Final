//
//  WardrobeShakeView.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SpriteKit

class WardrobeShakeView: SKScene, ObservableObject, SKPhysicsContactDelegate {
    
    var hasFallen = false {
        didSet {
            print("fallen")
            updateKeyTexture()
        }
    }
    
    @Published var hasTapped = false
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    let keyCategory: UInt32 = 0x1 << 0
    let platformCategory: UInt32 = 0x1 << 1
    
    @Published var rotationAngle: Double = 0.0 {
        didSet {
            // Constrain the rotation angle
            let maxRotationAngle = Double.pi / 15
            if rotationAngle > maxRotationAngle {
                rotationAngle = maxRotationAngle
            } else if rotationAngle < -maxRotationAngle {
                rotationAngle = -maxRotationAngle
            }
            
            if let wardrobe = self.childNode(withName: "wardrobe") as? SKSpriteNode {
                let rotateAction = SKAction.rotate(toAngle: CGFloat(-rotationAngle), duration: 0.3, shortestUnitArc: true)
                wardrobe.run(rotateAction)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        self.physicsWorld.contactDelegate = self
        createBackground()
        createWardrobe()
        createPlatform()
        createLeftPlatform()
        createRightPlatform()
        createKey()
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "level1_bg")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = self.size
        background.zPosition = -1
        background.texture?.filteringMode = .nearest
        self.addChild(background)
    }
    
    func createWardrobe() {
        let wardrobe = SKSpriteNode()
        wardrobe.texture = SKTexture(imageNamed: "Bookcase")
        wardrobe.size = CGSize(width: 200, height: 350)
        wardrobe.position = CGPoint(x: 250, y: 250)
        wardrobe.zRotation = CGFloat(rotationAngle)
        wardrobe.name = "wardrobe"
        
        wardrobe.physicsBody = SKPhysicsBody(rectangleOf: wardrobe.size)
        wardrobe.physicsBody?.isDynamic = false
        wardrobe.physicsBody?.affectedByGravity = false
        wardrobe.texture?.filteringMode = .nearest
        self.addChild(wardrobe)
    }
    
    func createPlatform() {
        let platform = SKSpriteNode()
        platform.size = CGSize(width: 500, height: 30)
        platform.color = .clear
        platform.position = CGPoint(x: 250, y: 50)
        platform.name = "platform"
        
        platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.affectedByGravity = false
        platform.physicsBody?.categoryBitMask = platformCategory
        platform.physicsBody?.contactTestBitMask = keyCategory
        self.addChild(platform)
    }
    
    func createLeftPlatform() {
        let leftPlatform = SKSpriteNode()
        leftPlatform.size = CGSize(width: 30, height: self.size.height)
        leftPlatform.color = .clear
        leftPlatform.position = CGPoint(x: 0, y: self.size.height / 2)
        leftPlatform.name = "leftPlatform"
        
        leftPlatform.physicsBody = SKPhysicsBody(rectangleOf: leftPlatform.size)
        leftPlatform.physicsBody?.isDynamic = false
        leftPlatform.physicsBody?.affectedByGravity = false
        leftPlatform.physicsBody?.categoryBitMask = platformCategory
        leftPlatform.physicsBody?.contactTestBitMask = keyCategory
        self.addChild(leftPlatform)
    }
    
    func createRightPlatform() {
        let rightPlatform = SKSpriteNode()
        rightPlatform.size = CGSize(width: 30, height: self.size.height)
        rightPlatform.color = .clear
        rightPlatform.position = CGPoint(x: self.size.width, y: self.size.height / 2)
        rightPlatform.name = "rightPlatform"
        
        rightPlatform.physicsBody = SKPhysicsBody(rectangleOf: rightPlatform.size)
        rightPlatform.physicsBody?.isDynamic = false
        rightPlatform.physicsBody?.affectedByGravity = false
        rightPlatform.physicsBody?.categoryBitMask = platformCategory
        rightPlatform.physicsBody?.contactTestBitMask = keyCategory
        self.addChild(rightPlatform)
    }
    
    func createKey() {
        let key = SKSpriteNode()
        key.texture = SKTexture(imageNamed: hasFallen ? "KeyFall" : "KeyTop")
        key.size = CGSize(width: hasFallen ? 50 : 40, height: hasFallen ? 65 : 20)
        key.position = CGPoint(x: 250, y: 355)
        key.name = "key"
        
        key.physicsBody = SKPhysicsBody(rectangleOf: key.size)
        key.physicsBody?.isDynamic = true
        key.physicsBody?.affectedByGravity = true
        key.physicsBody?.categoryBitMask = keyCategory
        key.physicsBody?.contactTestBitMask = platformCategory
        key.physicsBody?.friction = 0.0
        key.physicsBody?.linearDamping = 0.0
        key.texture?.filteringMode = .nearest
        
        self.addChild(key)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == keyCategory && contact.bodyB.categoryBitMask == platformCategory ||
            contact.bodyB.categoryBitMask == keyCategory && contact.bodyA.categoryBitMask == platformCategory {
            if let soundURL = Bundle.main.url(forResource: "KeyDropSFX", withExtension: "wav") {
                AudioPlayer.playSound(url: soundURL, withID: "KeyDropSFX")
            }
            feedback.impactOccurred()
            hasFallen = true
        }
    }
    
    func updateKeyTexture() {
        if let key = self.childNode(withName: "key") as? SKSpriteNode {
            key.texture = SKTexture(imageNamed: hasFallen ? "KeyFall" : "KeyTop")
            key.size = CGSize(width: hasFallen ? 50 : 40, height: hasFallen ? 65 : 20)
            key.texture?.filteringMode = .nearest
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes {
                if node.name == "key" {
                    if hasFallen {
                        print("true")
                        if let keyNode = node as? SKSpriteNode {
                            animateKey(keyNode)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                self.hasTapped = true
                            }
                        }
                    } else {
                        print("false")
                    }
                }
            }
        }
    }
    
    
    private func animateKey(_ keyNode: SKSpriteNode) {
        let scaleAction = SKAction.scale(by: 2, duration: 1)
        let reverseAction = scaleAction.reversed()
        let sequence = SKAction.sequence([scaleAction, reverseAction])
        keyNode.zPosition = 10
        keyNode.run(sequence)
    }
}

//#Preview {
//    let scene = WardrobeShakeView(size: CGSize(width: 500, height: 500))
//    let view = SKView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
//    view.presentScene(scene)
//    return view
//}
