//
//  TilePhysicsExtension.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SpriteKit

extension GameScene {
    func tilePhysics(map: SKTileMapNode) {
        let tileMap = map
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    let tileArray = tileDefinition.textures
                    let tileTextures = tileArray[0]
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width / 2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height / 2)
                    
                    let tileNode = SKSpriteNode(texture: tileTextures)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTextures, size: CGSize(width: tileTextures.size().width, height: tileTextures.size().height))
                    
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: tileSize)
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.friction = 1
                    tileNode.physicsBody?.categoryBitMask = bitMasks.wall.rawValue
                    tileNode.physicsBody?.contactTestBitMask = bitMasks.hero.rawValue
                    tileNode.physicsBody?.collisionBitMask = bitMasks.hero.rawValue
                    tileNode.zPosition = 1
                    tileNode.anchorPoint = .init(x: 0.5, y: 0.5)
                    
                    tileNode.texture?.filteringMode = .nearest
                    // Tag the node for easy identification
//                    tileNode.name = "furniture"
                    
                    self.addChild(tileNode)
                }
            }
        }
    }
}

