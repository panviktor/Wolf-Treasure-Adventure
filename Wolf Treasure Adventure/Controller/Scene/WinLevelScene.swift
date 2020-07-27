//
//  WinLevelScene.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class WinLevelScene: SKScene {
    private let sceneManager = SceneManager.shared
    private let screenSize: CGRect = UIScreen.main.bounds
    override func didMove(to view: SKView) {
        loadBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.crossFade(withDuration: 1.0)
        guard let gameScene = sceneManager.gameScene else { return }
        gameScene.scaleMode = .aspectFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }
    
    private func loadBackground() {
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.winLevelSceneBackground))
        bg.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        self.addChild(bg)
    }
}


