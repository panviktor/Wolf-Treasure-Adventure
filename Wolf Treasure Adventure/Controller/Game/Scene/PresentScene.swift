//
//  PresentScene.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 04.08.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class PresentScene: SKScene {
    private enum State {
        case Select
    }
    
    private enum PresentSceneButton: String {
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
        let loadBackground = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.PresentScene.presentSceneBackground))
        loadBackground.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        loadBackground.size = CGSize(width: screenSize.width, height: screenSize.height)
        loadBackground.zPosition = -10
        
        let titleLabel = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.PresentScene.presentSceneTextLabel))
        titleLabel.anchorPoint = CGPoint(x: 0.0, y: 0.65)
        titleLabel.size = CGSize(width: screenSize.width, height: screenSize.height * 0.15)
        titleLabel.position.y = screenSize.size.height * 0.915
        titleLabel.zPosition = -9
        
        mainBoard.texture = SKTexture(imageNamed: ImageName.PresentScene.presentSceneMainBoard)
        mainBoard.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        mainBoard.size = CGSize(width: screenSize.width * 0.98, height: screenSize.width * 0.98)
        mainBoard.position.x = screenSize.width - screenSize.width * 0.99
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
        presentGrid()
        try? audioVibroManager.playMusic(type: .priceSceneBackground)
    }
    
    private func addButton() {
        let backButton = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.PresentScene.presentSceneBackButton))
        backButton.name = PresentSceneButton.BackButton.rawValue
        backButton.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        backButton.position = CGPoint(x: buttonNode.size.width * 0.025, y: 0)
        backButton.size = CGSize(width:  buttonNode.size.width / 2.20,
                                 height: buttonNode.size.height * 0.95)
        
        let applyButton = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.PresentScene.presentSceneApplyButton))
        applyButton.name = PresentSceneButton.ApplyButton.rawValue
        applyButton.anchorPoint = CGPoint(x: 1, y: 1.0)
        applyButton.position = CGPoint(x: buttonNode.size.width * 0.975, y: 0)
        applyButton.size = CGSize(width:  buttonNode.size.width / 2.20,
                                  height: buttonNode.size.height * 0.95)
        
        buttonNode.addChild(backButton)
        buttonNode.addChild(applyButton)
    }
    
    private func presentGrid() {
        if let grid = Grid(blockSize: mainBoard.size.width / 3.5, rows: 3, columns: 3) {
            grid.position = CGPoint (x: mainBoard.frame.midX, y: mainBoard.frame.midY)
            addChild(grid)
            
            var currentSkin =  ImageName.PresentScene.PresentSceneSkinPrice.Present_1
            for row in 0...2 {
                for column in 0...2 {
                    let price = SKSpriteNode(imageNamed: currentSkin.description)
                    currentSkin = currentSkin.next
                    price.size =  CGSize(width: mainBoard.size.width / 3.8, height: mainBoard.size.width / 3.8)
                    price.position = grid.gridPosition(row: row, column: column)
                    grid.addChild(price)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var pos:CGPoint!
        for touch in touches{
            pos = touch.location(in: self)
        }
        
        switch state {
        case .Select:
            for c in nodes(at: pos){
                if c.name == PresentSceneButton.BackButton.rawValue {
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
