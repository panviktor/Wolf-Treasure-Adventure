//
//  MainScene.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 27.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate {
    enum Scene {
        case MainScene
        case GameScene
        
        case GameSettingsScene
        case TopScoreScene
        
        case EndChapterScene
        case WinLevelScene
    }
    
    private  enum MainSceneButton: String {
        case PlayButton
        case SettingsButton
        case ScoreButton
    }
    
    private   let sceneManager = SceneManager.shared
    private  let screenSize: CGRect = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        guard sceneManager.gameScene == nil else { return }
        sceneManager.gameScene = self
        removeUIViews()
        // Setting up delegate for Physics World & Set up gravity
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        loadBackground()
    }
    
    private func loadBackground(){
        let mainSceneBackground = SKSpriteNode()
        mainSceneBackground.texture = SKTexture(imageNamed: ImageName.mainSceneBackground)
        mainSceneBackground.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        mainSceneBackground.size = CGSize(width: screenSize.width, height: screenSize.height)
        mainSceneBackground.zPosition = -10
        mainSceneBackground.name = ImageName.mainSceneBackground
        self.addChild(mainSceneBackground)
        
        let cloud = SKSpriteNode()
        cloud.texture = SKTexture(imageNamed: ImageName.mainSceneCloud)
        cloud.position = CGPoint(x: screenSize.width/2, y: screenSize.height*0.40)
        cloud.size = CGSize(width: screenSize.width, height: screenSize.height*3/4)
        cloud.zPosition = -9
        cloud.name = ImageName.mainSceneCloud
        self.addChild(cloud)
        
        let root = SKSpriteNode()
        root.color = .clear
        root.name = "RootSKSpriteNode"
        root.size = CGSize(width: screenSize.width, height: screenSize.height * 0.7)
        root.position = CGPoint(x: screenSize.width / 2, y: screenSize.height * 0.55)
        root.zPosition = -7
        self.addChild(root)
        
        let bd_one_button = createUIButton(name: MainSceneButton.PlayButton, offsetPosX: 0, offsetPosY: 0)
        root.addChild(bd_one_button)
        
        let bd_two_button = createUIButton(name: MainSceneButton.SettingsButton, offsetPosX: 10, offsetPosY: 10)
        root.addChild(bd_two_button)
        
        let bd_three_button = createUIButton(name: MainSceneButton.ScoreButton, offsetPosX: 20, offsetPosY: 20)
        root.addChild(bd_three_button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var pos: CGPoint!
        for touch in touches {
            pos = touch.location(in: self)
        }
        
        let childs = self.nodes(at: pos)
        for c in childs {
            if c.name == MainSceneButton.PlayButton.rawValue {
                prepareToChangeScene(scene: .GameScene)
            } else if c.name == MainSceneButton.SettingsButton.rawValue {
                prepareToChangeScene(scene: .GameSettingsScene)
            } else if c.name == MainSceneButton.ScoreButton.rawValue {
                prepareToChangeScene(scene: .TopScoreScene)
            }
        }
    }
    
    private func createUIButton(name: MainSceneButton,
                                offsetPosX dx:CGFloat,
                                offsetPosY dy:CGFloat) -> SKSpriteNode {
        
        let button = SKSpriteNode()
        button.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        switch name {
        case .PlayButton:
            button.texture = SKTexture(imageNamed: ImageName.mainScenePlayButton)
        case .SettingsButton:
            button.texture = SKTexture(imageNamed: ImageName.mainSceneSettingsButton)
        case .ScoreButton:
            button.texture = SKTexture(imageNamed: ImageName.mainSceneScoreButton)
        }
        
        button.position = CGPoint(x: dx, y: dy)
        button.size = CGSize(width: screenSize.width / 4, height: screenSize.height / 16)
        button.name = name.rawValue
        return button
    }
    
    func prepareToChangeScene(scene: Scene){
        // remove all gestures
        if scene != .WinLevelScene {
            for gesture in (view?.gestureRecognizers)!{
                view?.removeGestureRecognizer(gesture)
            }
        }
        
        switch scene {
        case .MainScene:
            debugPrint("Something go wrong?")
            break
        case .GameScene:
            self.recursiveRemovingSKActions(sknodes: self.children)
            self.removeAllChildren()
            self.removeAllActions()
            let newScene = GameScene(size: self.size)
            self.view?.presentScene(newScene)
            
        case .GameSettingsScene:
            self.recursiveRemovingSKActions(sknodes: self.children)
            self.removeAllChildren()
            self.removeAllActions()
            let newScene = GameSettingsScene(size: self.size)
            self.view?.presentScene(newScene)
            
        case .TopScoreScene:
            self.recursiveRemovingSKActions(sknodes: self.children)
            self.removeAllChildren()
            self.removeAllActions()
            let newScene = TopScoreScene(size: self.size)
            self.view?.presentScene(newScene)
            
        case .EndChapterScene:
            self.run(SKAction.sequence([SKAction.wait(forDuration: 4), SKAction.run {
                self.recursiveRemovingSKActions(sknodes: self.children)
                self.removeAllChildren()
                self.removeAllActions()
                let scene = EndChapterScene(size: self.size)
                self.view?.presentScene(scene)
                }]))
            
        case .WinLevelScene:
            let transition = SKTransition.doorway(withDuration: 0.5)
            let winLevel = WinLevelScene(size: self.size)
            winLevel.scaleMode = .aspectFill
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene!.view?.presentScene(winLevel, transition: transition)
        }
    }
}
