//
//  GameManager.swift
//  Wolf Treasure Adventure
//
//  Created by Viktor on 30.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation

final class GameManager {
    private let defaults = UserDefaults.standard
    
    private(set) var currentLevel: Int {
        get {
            return defaults.object(forKey: "currentLevel") as? Int ?? 1
        } set (newValue) {
            if newValue <= GameConfiguration.maximumLevel {
                defaults.set(newValue, forKey: "currentLevel")
            }
        }
    }
    
    private(set) var currentScore: Int {
        get {
            return defaults.object(forKey: "currentScore") as? Int ?? 0
        } set (newValue) {
            defaults.set(newValue, forKey: "currentScore")
        }
    }
    
    private(set) var currentPresent: Int {
        get {
            return defaults.object(forKey: "currentPresent") as? Int ?? 5
        } set (newValue) {
            defaults.set(newValue, forKey: "currentPresent")
        }
    }
    
    static let shared = GameManager()
    fileprivate init() {}
    
    func addLevel() {
        currentLevel += 1
    }
    
    func addScore() {
        currentScore += 1
    }
    
    func setupPresent(number: Int) {
        currentPresent = number
    }
    
    func resetAll() {
        currentLevel = 1
        currentScore = 0
    }
}
