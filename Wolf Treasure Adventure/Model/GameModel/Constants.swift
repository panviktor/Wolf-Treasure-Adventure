import CoreGraphics

enum ImageName {
    static let background = "Background"
    static let ground = "Ground"
    static let water = "Water"
    static let vineTexture = "VineTexture"
    static let vineHolder = "VineHolder"
    static let crocMouthClosed = "CrocMouthClosed"
    static let crocMouthOpen = "CrocMouthOpen"
    static let crocMask = "CrocMask"
    static let prize = "Pineapple"
    static let prizeMask = "PineappleMask"
    
    static let woodTexture = "Wood"
}

enum SoundFile {
    static let backgroundMusic = "CheeZeeJungle.caf"
    static let slice = "Slice.caf"
    static let splash = "Splash.caf"
    static let nomNom = "NomNom.caf"
}

enum Layer {
    static let background: CGFloat = 0
    static let crocodile: CGFloat = 1
    static let vine: CGFloat = 1
    static let wood: CGFloat = 2
    static let prize: CGFloat = 3
    static let foreground: CGFloat = 4
}

enum PhysicsCategory {
    static let crocodile: UInt32 = 1
    static let vineHolder: UInt32 = 2
    static let vine: UInt32 = 4
    static let prize: UInt32 = 8
    static let wood: UInt32 = 16
}

enum GameConfiguration {
    static let canCutMultipleVinesAtOnce = false
    static let maximumLevel = 3
}

enum Scene {
    static let particles = "Particle.sks"
}

enum PrizeType: String {
    case common = "Common"
    case rare = "Rare"
    case unique = "Unique"
}
