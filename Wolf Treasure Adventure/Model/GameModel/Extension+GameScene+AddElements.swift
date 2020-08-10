//
//  WoodNode.swift
//  Wolf Treasure Adventure
//
//  Created by Виктор on 26.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

extension GameScene {
    func addWoodToScene(_ position: CGPoint, _ rotation: CGFloat) {
        let wood = SKSpriteNode(imageNamed: ImageName.woodTexture)
        wood.size = CGSize(width: 100, height: 10)
        wood.position = CGPoint(x: position.x, y: position.y)
        wood.zRotation = .pi / rotation
        wood.zPosition = Layers.wood
        wood.physicsBody = SKPhysicsBody(texture:  SKTexture(imageNamed: ImageName.woodTexture), size: wood.size)
        wood.physicsBody?.categoryBitMask = PhysicsCategoryBitMask.wood
        wood.physicsBody?.collisionBitMask = PhysicsCategoryBitMask.prize
        wood.physicsBody?.restitution = 0.7
        wood.physicsBody?.isDynamic = false
        
        addChild(wood)
    }
    
    func addObjectOneToScene(_ position: CGPoint, _ rotation: CGFloat) {
        let object = SKSpriteNode(imageNamed: ImageName.physicalObjectOneTexture)
        object.size = CGSize(width: 45, height: 45)
        object.position = CGPoint(x: position.x, y: position.y)
        object.zRotation = .pi / rotation
        object.zPosition = Layers.physicalObjectOne
        object.physicsBody = SKPhysicsBody(texture:  SKTexture(imageNamed: ImageName.physicalObjectOneTexture), size: object.size)
        object.physicsBody?.categoryBitMask = PhysicsCategoryBitMask.physicalObjectOne
        object.physicsBody?.collisionBitMask = PhysicsCategoryBitMask.prize
        object.physicsBody?.restitution = 0.3
        object.physicsBody?.isDynamic = false
        print(#line, #function)
        addChild(object)
    }
    
    func addObjectTwoToScene(_ position: CGPoint, _ rotation: CGFloat) {
        let object = SKSpriteNode(imageNamed: ImageName.physicalObjectTwoTexture)
        object.size = CGSize(width: 45, height: 45)
        object.position = CGPoint(x: position.x, y: position.y)
        object.zRotation = .pi / rotation
        object.zPosition = Layers.physicalObjectTwo
        object.physicsBody = SKPhysicsBody(texture:  SKTexture(imageNamed: ImageName.physicalObjectTwoTexture), size: object.size)
        object.physicsBody?.categoryBitMask = PhysicsCategoryBitMask.physicalObjectTwo
        object.physicsBody?.collisionBitMask = PhysicsCategoryBitMask.prize
        object.physicsBody?.restitution = 0.4
        object.physicsBody?.isDynamic = false
        print(#line, #function)
        addChild(object)
    }
    
    func addObjectThreeToScene(_ position: CGPoint, _ rotation: CGFloat) {
        let object = SKSpriteNode(imageNamed: ImageName.physicalObjectThreeTexture)
        object.size = CGSize(width: 45, height: 45)
        object.position = CGPoint(x: position.x, y: position.y)
        object.zRotation = .pi / rotation
        object.zPosition = Layers.physicalObjectTree
        object.physicsBody = SKPhysicsBody(texture:  SKTexture(imageNamed: ImageName.physicalObjectThreeTexture), size: object.size)
        object.physicsBody?.categoryBitMask = PhysicsCategoryBitMask.physicalObjectThree
        object.physicsBody?.collisionBitMask = PhysicsCategoryBitMask.prize
        object.physicsBody?.restitution = 0.5
        object.physicsBody?.isDynamic = false
        print(#line, #function)
        addChild(object)
    }
    
}

