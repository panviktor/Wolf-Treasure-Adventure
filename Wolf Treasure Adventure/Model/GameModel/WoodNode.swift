//
//  WoodNode.swift
//  Wolf Treasure Adventure
//
//  Created by Виктор on 26.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class WoodNode: SKNode {
    private let anchorPoint: CGPoint
    init(length: Int, anchorPoint: CGPoint, name: String) {
        self.anchorPoint = anchorPoint
        super.init()
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        anchorPoint = aDecoder.decodeCGPoint(forKey: "anchorPoint")
        super.init(coder: aDecoder)
    }
}



//    woods = SKSpriteNode(imageNamed: ImageName.woodTexture)
//    woods.position = CGPoint(x: size.width * level.prizePosition.x,
//        y: level.prizePosition.y)
//    woods.zPosition = Layer.wood
//    woods.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ImageName.woodTexture),
//                                       size: woods?.size ?? CGSize.zero)
//    woods.physicsBody?.categoryBitMask = PhysicsCategory.prize
//    woods.physicsBody?.collisionBitMask = 0
//    woods.physicsBody?.density = 0.5
