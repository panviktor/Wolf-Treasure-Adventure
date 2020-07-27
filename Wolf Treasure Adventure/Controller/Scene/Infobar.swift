import SpriteKit

struct Currency {
    enum CurrencyType {
        case Coin
    }
}

class Infobar: SKSpriteNode{
    private enum Template{
        case First // Display Level &E xp
        case Second // Display account's money
        case Third // Display trophy currency
        case Fourth // For settings - Not implemented yet
        case Fifth // Above the 'Fourth' Label. Visible once game state == .Start
    }
    
    let sceneManager = SceneManager.shared
    let screenSize: CGRect = UIScreen.main.bounds
    
    private let mainRootWidth: CGFloat = UIScreen.main.bounds.width
    private let mainRootHeight: CGFloat = 100
    private var firstTemplate: SKSpriteNode!
    private var secondTemplate: SKSpriteNode!
    private var thirdTemplate: SKSpriteNode!
    private var fourthTemplate: SKSpriteNode!
    private var fifthTemplate: SKSpriteNode!
    
    convenience init(name n: String){
        self.init()
        let rootItemSize = CGSize(width: screenSize.width / 4, height: screenSize.height * 0.05)
        
        name = n
        color = .clear
        
        size = CGSize(width: mainRootWidth, height: mainRootHeight)
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        position = CGPoint(x: 0, y: screenSize.height * 0.85)
        // Main_Menu_Currency_Bar
        firstTemplate = generateTemplate(templateStyle: .First, itemSize: rootItemSize, name: "topbar_first_item",  previousPos: nil)
        secondTemplate = generateTemplate(templateStyle: .Second, itemSize: rootItemSize, name: "topbar_second_item",  previousPos: firstTemplate.position)
        thirdTemplate = generateTemplate(templateStyle: .Third, itemSize: rootItemSize, name: "topbar_third_item", previousPos: secondTemplate.position)
        fourthTemplate = generateTemplate(templateStyle: .Fourth, itemSize: rootItemSize, name: "topbar_fourth_item", previousPos: thirdTemplate.position)
        
        fifthTemplate = customFifthLabel(itemSize: rootItemSize, prevNodePosition: thirdTemplate.position)
        
        addChild(firstTemplate)
        addChild(secondTemplate)
        addChild(thirdTemplate)
        addChild(fourthTemplate)
        addChild(fifthTemplate)
    }
    
    private func makeTemplateNode(width w:CGFloat, height h:CGFloat, dx:CGFloat, name n:String) -> SKSpriteNode {
        let node = SKSpriteNode()
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.color = .clear
        node.name = n
        node.size = CGSize(width: w, height: h)
        node.position = CGPoint(x: dx, y: self.size.height - h)
        return node
    }
    
    private func generateTemplate(templateStyle:Template,
                                  itemSize: CGSize, name n:String, previousPos prev:CGPoint?) -> SKSpriteNode{
        
        var px: CGFloat!
        let (w, h) = (itemSize.width, itemSize.height)
        
        px = (prev == nil) ? 0.0 : prev!.x + w
        
        let node = makeTemplateNode(width: w, height: h, dx: px,  name: n)
        // Filling the template -->
        
        // Bar Default Values
        let barWidth:CGFloat = node.size.width * 0.8
        let barHeight:CGFloat = node.size.height * 0.55
        let barXpos:CGFloat = node.size.width
        let barYpos:CGFloat = 0
        
        // Icon Default Values
        let icon = SKSpriteNode()
        let iconWidth:CGFloat = node.size.height * 0.95
        let iconHeight:CGFloat = node.size.height * 0.95
        let iconXpos:CGFloat = node.size.width -  barWidth
        let iconYpos:CGFloat = -3
        
        icon.anchorPoint = CGPoint(x: 0.5, y: 0.1)
        icon.zPosition = 1
        icon.name = ""
        icon.size = CGSize(width: iconWidth, height: iconHeight)
        icon.position = CGPoint(x: iconXpos, y: iconYpos)
        icon.texture = SKTexture(imageNamed: "")
        node.addChild(icon)
        
        // icon position might be changed with the if condition below:
        if templateStyle == .First {
            let newWidth:CGFloat = node.size.width * 0.5
            let newHeight:CGFloat = node.size.height * 0.65
            
            let bar = SKSpriteNode()
            bar.anchorPoint = CGPoint(x: 1.0, y: 0)
            bar.name = "bar"
            bar.size = CGSize(width: newWidth, height: newHeight)
            bar.texture = SKTexture(imageNamed: "")
            bar.position = CGPoint(x: barXpos * 0.8, y: barYpos)
            node.addChild(bar)
            
            // Adjusting Icon
            icon.position.x = node.size.width - newWidth - barXpos * 0.2
            icon.position.y = 0
        }
        else if templateStyle == .Second || templateStyle == .Third {
            let rect = CGRect(x: self.size.width*0.038, y: 0, width: barWidth, height: barHeight)
            let bar = SKShapeNode(rect: rect, cornerRadius: screenSize.height * 0.01)
            bar.alpha = 0.65
            bar.fillColor = .white
            bar.strokeColor = .clear
            bar.name = "bar"
            node.addChild(bar)
            
            let label = SKLabelNode(fontNamed: "KohinoorTelugu-Medium")
            label.zPosition = 1
            label.fontSize = barWidth/5
            label.horizontalAlignmentMode = .right
            label.verticalAlignmentMode = .center
            label.position.x += node.size.width * 0.9
            label.position.y += barHeight/2.8
            label.name = "label"
            
            if templateStyle == .Second {
                label.text = "123"
                label.fontColor = SKColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                bar.addChild(label.shadowNode(nodeName: "labelCoinEffect"))
            } else {
                label.text = "0"
                label.fontColor = SKColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                bar.addChild(label.shadowNode(nodeName: "labelTrophyEffect"))
            }
        }
        else if templateStyle == .Fourth{
            // This place will be the settings. Still not available
            icon.isHidden = true
        }
        
        return node
    }
    
    // fourth item
    private func customFifthLabel(itemSize:CGSize, prevNodePosition prev:CGPoint) -> SKSpriteNode{
        let width = itemSize.width
        let height = itemSize.height
        let node = makeTemplateNode(width: width, height: height, dx: prev.x + itemSize.width, name: "topbar_right_corner")
        node.position.y += 100 // decrease 100 to show to user

        node.alpha = 0.0
        return node
    }
    
    func updateGoldLabel(coinCount:Int) {
        guard let coinShadowLabel = fifthTemplate.childNode(withName: "coinLabelName") as? SKEffectNode else{
            print ("ERROR A01: Check updateGoldLabel method from Class Infobar")
            return
        }
        guard let coinLabel = coinShadowLabel.childNode(withName: "coinText") as? SKLabelNode else{
            print ("ERROR A02: Check updateGoldLabel method from Class Infobar")
            return
        }
        
        coinLabel.text = numberToString(num: coinCount)
    }
    
    func updateGoldBalnceLabel(balance:Int){
        guard let coinBarLabel = secondTemplate.childNode(withName: "bar") else{
            print ("ERROR A00: Check updateGoldLabel method from Class Infobar")
            return
        }
        guard let coinShadowLabel = coinBarLabel.childNode(withName: "labelCoinEffect") as? SKEffectNode else{
            print ("ERROR A01: Check updateGoldLabel method from Class Infobar")
            return
        }
        guard let coinLabel = coinShadowLabel.childNode(withName: "label") as? SKLabelNode else{
            print ("ERROR A02: Check updateGoldLabel method from Class Infobar")
            return
        }
        coinLabel.text = numberToString(num: balance)
    }
    
    func fadeAway(){
        let fadeAwayAction = SKAction.fadeAlpha(to: 0, duration: 0.2)
        
        let showCoinLabelAction = SKAction.group([SKAction.moveBy(x: 0, y: -100, duration: 0.3), SKAction.fadeAlpha(to: 1.0, duration: 0.3)])
        
        firstTemplate.run(fadeAwayAction)
        secondTemplate.run(fadeAwayAction)
        thirdTemplate.run(fadeAwayAction)
        fourthTemplate.run(fadeAwayAction)
        fifthTemplate.run(showCoinLabelAction)
    }
    
    private func numberToString(num:Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: num as NSNumber)!
    }
}


