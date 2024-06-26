//
//  AddHeroExtension.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SpriteKit

extension GameScene {
    func addHero() {
        hero = childNode(withName: "character") as! SKSpriteNode
        hero.zPosition = 50
        hero.physicsBody = SKPhysicsBody(texture: hisTexture, size: hero.size)
        hero.physicsBody?.categoryBitMask = bitMasks.hero.rawValue
        hero.physicsBody?.contactTestBitMask = bitMasks.wall.rawValue | bitMasks.bed.rawValue
        hero.physicsBody?.collisionBitMask = bitMasks.wall.rawValue | bitMasks.bed.rawValue
        hero.physicsBody?.affectedByGravity = false
        hero.physicsBody?.allowsRotation = false
        hero.texture?.filteringMode = .nearest
        hero.alpha = 0.5
        hero.name = "character"
        actionSign = SKSpriteNode(imageNamed: "actionSign")
        actionSign.size = CGSize(width: 5, height: 15)
        actionSign.zPosition = 50
        actionSign.position = CGPoint(x: -10, y: 15)
        actionSign.isHidden = true
        actionSign.name = "actionSign"
        hero.addChild(actionSign)
    }
    
    func addPolice() {
        police = childNode(withName: "police") as! SKSpriteNode
        police.zPosition = 51
        police.name = "police"
        
        policeRightFrames = loadFrames(fromAtlas: "police_right", frameCount: 8)
        policeDownFrames = loadFrames(fromAtlas: "police_down", frameCount: 8)
        policeLeftFrames = loadFrames(fromAtlas: "police_left", frameCount: 8)
        policeUpFrames = loadFrames(fromAtlas: "police_up", frameCount: 8)
    }
    
    func loadFrames(fromAtlas atlasName: String, frameCount: Int) -> [SKTexture] {
        var frames: [SKTexture] = []

        for index in 1...frameCount {
            let textureName = "\(atlasName)\(index)"
            frames.append(SKTexture(imageNamed: textureName))
        }
        
        return frames
    }
    
    func animatePoliceRight() -> SKAction {
        let animation = SKAction.animate(with: policeRightFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }

    func animatePoliceDown() -> SKAction {
        let animation = SKAction.animate(with: policeDownFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }

    func animatePoliceLeft() -> SKAction {
        let animation = SKAction.animate(with: policeLeftFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }

    func animatePoliceUp() -> SKAction {
        let animation = SKAction.animate(with: policeUpFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }
    
    func addPoliceMovement() {
        let initialPosition = police.position
        let boxWidth: CGFloat = 100.0
        let boxHeight: CGFloat = 50
        
        let topLeft = CGPoint(x: initialPosition.x, y: initialPosition.y + boxHeight)
        let topRight = CGPoint(x: initialPosition.x + boxWidth, y: initialPosition.y + boxHeight)
        let bottomLeft = CGPoint(x: initialPosition.x, y: initialPosition.y)
        let bottomRight = CGPoint(x: initialPosition.x + boxWidth, y: initialPosition.y)
        
        let moveToTopLeft = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.police.run(self?.animatePoliceUp() ?? SKAction(), withKey: "animation")
            },
            SKAction.move(to: topLeft, duration: 2.0),
            SKAction.run { [weak self] in
                self?.police.removeAction(forKey: "animation")
            }
        ])
        let moveToTopRight = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.police.run(self?.animatePoliceRight() ?? SKAction(), withKey: "animation")
            },
            SKAction.move(to: topRight, duration: 4.0),
            SKAction.run { [weak self] in
                self?.police.removeAction(forKey: "animation")
            }
        ])
        let moveToBottomRight = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.police.run(self?.animatePoliceDown() ?? SKAction(), withKey: "animation")
            },
            SKAction.move(to: bottomRight, duration: 2.0),
            SKAction.run { [weak self] in
                self?.police.removeAction(forKey: "animation")
            }
        ])
        let moveToBottomLeft = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.police.run(self?.animatePoliceLeft() ?? SKAction(), withKey: "animation")
            },
            SKAction.move(to: bottomLeft, duration: 4.0),
            SKAction.run { [weak self] in
                self?.police.removeAction(forKey: "animation")
            }
        ])
        
        let moveSequence = SKAction.sequence([moveToTopLeft, moveToTopRight, moveToBottomRight, moveToBottomLeft])
        let repeatMovement = SKAction.repeatForever(moveSequence)
        
        police.run(repeatMovement, withKey: "boxMovement")
    }
}
