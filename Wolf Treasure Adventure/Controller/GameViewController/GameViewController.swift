import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func loadView() {
        self.view = SKView()
    }
    
    //MARK: - Custom Methods
    private func load(){
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        
        // Create and configure the scene.
//        let scene = GameScene(size: CGSize(width: 375, height: 667))
        
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}

