//
//  WoodNode.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 24.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class WoodNode: SKNode {
    private let anchorPoint: CGPoint
    private var woods: [SKNode] = []
    
    init(anchorPoint: CGPoint, name: String) {
        self.anchorPoint = anchorPoint
        super.init()
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        anchorPoint = aDecoder.decodeCGPoint(forKey: "anchorPoint")
        super.init(coder: aDecoder)
    }
    
    func addToScene(_ scene: SKScene) {
        // add vine to scene
        zPosition = Layer.wood
        scene.addChild(self)
        
  
    }
}

