//
//  AddCollisionExtension.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SpriteKit

extension GameScene {
    func addCollisions(names: [String]) {
        for name in names {
            if let node = childNode(withName: name) as? SKSpriteNode {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.isDynamic = false
                node.physicsBody?.categoryBitMask = bitMasks.bed.rawValue
                node.physicsBody?.contactTestBitMask = bitMasks.hero.rawValue
                node.physicsBody?.collisionBitMask = bitMasks.hero.rawValue
                node.name = name
                node.zPosition = 4
                node.texture?.filteringMode = .nearest
            }
        }
    }
}
