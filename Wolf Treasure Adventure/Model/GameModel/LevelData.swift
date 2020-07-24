import UIKit

// MARK: - LevelData
struct LevelData: Codable {
    let levelName: String
    let levelNumber: Int
    let heroesPosition: ItemPosition
    let vines: [Vine]
    let prizeType: Int
    let prizePosition: ItemPosition
    let items: [Item]?
    let bonusScore: Int?
    
    static func loadFrom(file filename: String) -> LevelData? {
        var data: Data
        var levelData: LevelData?
        
        if let path = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                data = try Data(contentsOf: path)
            } catch {
                print("Could not load level file: \(filename), error: \(error)")
                return nil
            }
            do {
                let decoder = JSONDecoder()
                levelData = try decoder.decode(LevelData.self, from: data)
            } catch {
                print("Level file '\(filename)' is not valid JSON: \(error)")
                return nil
            }
        }
        return levelData
    }
}

// MARK: - HeroesPosition
struct ItemPosition: Codable {
    let x: CGFloat
    let y: CGFloat
    var position: CGPoint {
        get { return CGPoint(x: x, y: y) }
    }
}

// MARK: - Item
struct Item: Codable {
    let type: String
    let layer: Int
    let physicsCategory: Int
    let xAnchorPoint: Double
    let yAnchorPoint: Double
    let itemsSize: ItemsSize
}

// MARK: - ItemsSize
struct ItemsSize: Codable {
    let width: CGFloat
    let height: CGFloat
}

// MARK: - Vine
struct Vine: Codable {
    let length: Int
    let xAnchorPoint: CGFloat
    let yAnchorPoint: CGFloat
}

