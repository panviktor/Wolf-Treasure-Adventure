//
//  TopScoreScene.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class TopScoreScene: SKScene {
    private enum State {
        case Select
    }
    
    private enum TopScoreSceneButton: String {
        case BackButton
    }
    
    private var scoreNode = SKSpriteNode()
    private var state:State = .Select
    private weak var scoreManager = ScoreManager.shared
    private let sceneManager = SceneManager.shared
    private let screenSize: CGRect = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadBackground()
        load()
    }
    
    private func loadBackground() {
        let loadBackground = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.topScoreSceneBackground))
        loadBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadBackground.size = CGSize(width: screenSize.width, height: screenSize.height)
        loadBackground.zPosition = -10
        self.addChild(loadBackground)
    }
    
    private func load(){
        //GameInfo Load
        let infobar = self.childNode(withName: "infobar")!
        infobar.position.y -= screenSize.size.height/2
        infobar.position.x -= screenSize.size.width/2
        
        // Title
        let title = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.topScoreSceneTitleLabel))
        title.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        title.position.y = screenSize.size.height / 3.5
        title.size = CGSize(width: screenSize.width * 0.6, height: screenSize.height * 0.12)
        
        let titleLabel = SKLabelNode(fontNamed: "PingFangSC-Regular")
        titleLabel.text = "Your Best Score"
        titleLabel.position.y = -title.size.height / 5.5
        titleLabel.fontColor = SKColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
        titleLabel.fontSize = screenSize.width / 15
        title.addChild(titleLabel.shadowNode(nodeName: "titleEffectNodeLabel"))
        
        self.addChild(title)
        
        // BackArrow
        let backarrow = SKSpriteNode(texture: SKTexture(imageNamed: ImageName.topScoreSceneBackButton))
        backarrow.name = TopScoreSceneButton.BackButton.rawValue
        backarrow.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        backarrow.position = CGPoint(x: -title.size.width/2 - 10, y: title.position.y + 3)
        backarrow.size = CGSize(width: screenSize.width/8, height: screenSize.height*0.06)
        self.addChild(backarrow)
        
        // scoreNode
        scoreNode.texture = SKTexture(imageNamed: ImageName.topScoreSceneNode)
        scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scoreNode.size = CGSize(width: screenSize.width/1.5, height: screenSize.height / 4)
        scoreNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 20, duration: 1),
                                                                SKAction.moveBy(x: 0, y: -20, duration: 1.2)])))
        
        let goldScore = SKLabelNode(fontNamed: "PingFangSC-Regular")
        goldScore.position.y = scoreNode.size.height / 4
        goldScore.text = "#1 \(scoreManager?.firstScore ?? 0)"
        goldScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        goldScore.fontSize = screenSize.width / 15
        scoreNode.addChild(goldScore.shadowNode(nodeName: "goldScoreLabel"))
        
        
        let silverScore = SKLabelNode(fontNamed: "PingFangSC-Regular")
        silverScore.position.y = scoreNode.size.height / 40
        silverScore.text = "#2 \(scoreManager?.secondScore ?? 0)"
        silverScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        silverScore.fontSize = screenSize.width / 17
        scoreNode.addChild(silverScore.shadowNode(nodeName: "silverScoreLabel"))
        
        
        let bronzeScore = SKLabelNode(fontNamed: "PingFangSC-Regular")
        bronzeScore.position.y = -scoreNode.size.height / 4
        bronzeScore.text = "#3 \(scoreManager?.thirdScore ?? 0)"
        bronzeScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        bronzeScore.fontSize = screenSize.width / 17
        scoreNode.addChild(bronzeScore.shadowNode(nodeName: "bronzeScoreLabel"))
        
        self.addChild(scoreNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var pos:CGPoint!
        for touch in touches{
            pos = touch.location(in: self)
        }
        
        switch state {
        case .Select:
            for c in nodes(at: pos){
                if c.name ==  TopScoreSceneButton.BackButton.rawValue {
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
