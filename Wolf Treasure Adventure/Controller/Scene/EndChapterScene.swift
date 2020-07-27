import SpriteKit

class EndChapterScene: SKScene {
    let sceneManager = SceneManager.shared
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        loadBackground()
    }
    
    private func loadBackground() {
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "EndChapterSceneBackground"))
        bg.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        bg.zPosition = -10
        self.addChild(bg)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneManager.gameScene = nil
        let scene = MainScene(size: self.size)
        self.view?.presentScene(scene)
    }
}