//
//  WoodNode.swift
//  Wolf Treasure Adventure
//
//  Created by Виктор on 26.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

extension GameScene {
    func addWoodToScene(_ anchorPoint: CGPoint) {
        let wood = SKSpriteNode(imageNamed: ImageName.woodTexture)
        wood.size = CGSize(width: 100, height: 20)

        wood.position = CGPoint(x: 200.5, y: 300.5)
//        wood.anchorPoint = anchorPoint
        
        wood.zPosition = Layer.wood
        wood.physicsBody = SKPhysicsBody(texture:  SKTexture(imageNamed: ImageName.woodTexture), size: wood.size)
        wood.physicsBody?.categoryBitMask = PhysicsCategory.wood
        wood.physicsBody?.collisionBitMask = 0
        wood.physicsBody?.contactTestBitMask = PhysicsCategory.wood
        wood.physicsBody?.isDynamic = false

       addChild(wood)
    }
}
