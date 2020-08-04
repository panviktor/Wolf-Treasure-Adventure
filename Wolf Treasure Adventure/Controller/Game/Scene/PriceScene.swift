//
//  PriceScene.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 04.08.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class PriceScene: SKScene {
    private enum State {
        case Select
    }
    
    private enum PriceSceneButton: String {
        case BackButton
        case ApplyButton
    }
    
    private let scoreNode = SKSpriteNode()
    private let buttonNode = SKSpriteNode()
    private let mainBoard = SKSpriteNode()
    
    private var state: State = .Select
    private let sceneManager = SceneManager.shared
    private let audioVibroManager = AudioVibroManager.shared
    private let gameManager = GameManager.shared
    private let screenSize: CGRect = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        loadBackground()
    }
    
    private func loadBackground() {
        let loadBackground = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.priceSceneBackground))
        loadBackground.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        loadBackground.size = CGSize(width: screenSize.width, height: screenSize.height)
        loadBackground.zPosition = -10
        
        let titleLabel = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.priceSceneTextLabel))
        titleLabel.anchorPoint = CGPoint(x: 0.0, y: 0.65)
        titleLabel.size = CGSize(width: screenSize.width, height: screenSize.height * 0.15)
        titleLabel.position.y = screenSize.size.height * 0.915
        titleLabel.zPosition = -9
        
        mainBoard.texture = SKTexture(imageNamed: ImageName.priceSceneMainBoard)
        mainBoard.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        mainBoard.size = CGSize(width: screenSize.width, height: screenSize.height / 2)
        mainBoard.position.y = (titleLabel.position.y - (titleLabel.size.width / 4.5))
        mainBoard.zPosition = -9
        
        buttonNode.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        buttonNode.size = titleLabel.size
        buttonNode.position.y = mainBoard.position.y - mainBoard.size.height - (mainBoard.size.height * 0.05)
        
        self.addChild(loadBackground)
        self.addChild(titleLabel)
        self.addChild(mainBoard)
        self.addChild(buttonNode)
        
        addButton()
        try? audioVibroManager.playMusic(type: .priceSceneBackground)
    }
    
    private func addButton() {
        let backButton = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.priceSceneBackButton))
        backButton.name = PriceSceneButton.BackButton.rawValue
        backButton.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        backButton.position = CGPoint(x: buttonNode.size.width * 0.025, y: 0)
        backButton.size = CGSize(width:  buttonNode.size.width / 2.20,
                                height: buttonNode.size.height * 0.95)
        
        let applyButton = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.priceSceneApplyButton))
        applyButton.name = PriceSceneButton.ApplyButton.rawValue
        applyButton.anchorPoint = CGPoint(x: 1, y: 1.0)
        applyButton.position = CGPoint(x: buttonNode.size.width * 0.975, y: 0)
        applyButton.size = CGSize(width:  buttonNode.size.width / 2.20,
                                height: buttonNode.size.height * 0.95)
        
        buttonNode.addChild(backButton)
        buttonNode.addChild(applyButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         var pos:CGPoint!
         for touch in touches{
             pos = touch.location(in: self)
         }
         
         switch state {
         case .Select:
             for c in nodes(at: pos){
                 if c.name == PriceSceneButton.BackButton.rawValue {
                     backButtonPressed()
                 }
             }
         }
     }
     
     private func backButtonPressed(){
         self.recursiveRemovingSKActions(sknodes: self.children)
         self.removeAllChildren()
         self.removeAllActions()
         sceneManager.mainScene = nil
         let newScene = MainScene(size: self.size)
         self.view?.presentScene(newScene)
     }
}


