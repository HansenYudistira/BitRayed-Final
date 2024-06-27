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
        
        protagonisRightFrames = loadFrames(fromAtlas: "protagonis_right", frameCount: 8)
        protagonisDownFrames = loadFrames(fromAtlas: "protagonis_down", frameCount: 8)
        protagonisLeftFrames = loadFrames(fromAtlas: "protagonis_left", frameCount: 8)
        protagonisUpFrames = loadFrames(fromAtlas: "protagonis_up", frameCount: 8)
        actionSign = SKSpriteNode(imageNamed: "actionSign")
        actionSign.size = CGSize(width: 5, height: 15)
        actionSign.zPosition = 50
        actionSign.position = CGPoint(x: -10, y: 15)
        actionSign.isHidden = true
        actionSign.name = "actionSign"
        hero.addChild(actionSign)
        
        possessionTimerLabel = SKLabelNode(fontNamed: "Arial")
        possessionTimerLabel.fontSize = 24
        possessionTimerLabel.fontColor = .white
        possessionTimerLabel.horizontalAlignmentMode = .left
        possessionTimerLabel.verticalAlignmentMode = .top
        possessionTimerLabel.position = CGPoint(x: -self.size.width / 2 + 10, y: self.size.height / 2 - 10)
        possessionTimerLabel.zPosition = 100
        possessionTimerLabel.isHidden = true
        cameraNode.addChild(possessionTimerLabel)
    }
    
    func addPolice() {
        police = childNode(withName: "police") as! SKSpriteNode
        police.zPosition = 51
        police.name = "police"
        
        police.texture?.filteringMode = .nearest
        
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
    
    func updateHeroAnimation(direction: AnimationDirection) {
        if direction != currentAnimationDirection {
            hero.removeAction(forKey: "heroAnimation")
            
            let animationAction: SKAction
            
            if isPossessed {
                switch direction {
                case .up:
                    animationAction = animatePoliceUp()
                case .down:
                    animationAction = animatePoliceDown()
                case .left:
                    animationAction = animatePoliceLeft()
                case .right:
                    animationAction = animatePoliceRight()
                case .none:
                    return
                }
            } else {
                switch direction {
                case .up:
                    animationAction = animateProtagonisUp()
                case .down:
                    animationAction = animateProtagonisDown()
                case .left:
                    animationAction = animateProtagonisLeft()
                case .right:
                    animationAction = animateProtagonisRight()
                case .none:
                    return
                }
            }
            
            hero.run(animationAction, withKey: "heroAnimation")
            currentAnimationDirection = direction
        }
    }
    
    func animateProtagonisRight() -> SKAction {
        let animation = SKAction.animate(with: protagonisRightFrames, timePerFrame: 0.2, resize: false, restore: false)
        
        return SKAction.repeatForever(animation)
    }

    func animateProtagonisDown() -> SKAction {
        let animation = SKAction.animate(with: protagonisDownFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }

    func animateProtagonisLeft() -> SKAction {
        let animation = SKAction.animate(with: protagonisLeftFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
    }

    func animateProtagonisUp() -> SKAction {
        let animation = SKAction.animate(with: protagonisUpFrames, timePerFrame: 0.2, resize: false, restore: false)
        return SKAction.repeatForever(animation)
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
