//
//  ScoreManager.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import Foundation

final class ScoreManager {
    let defaults = UserDefaults.standard
    
    private var allScore = [Int]()
    private(set) var firstScore: Int
    private(set) var secondScore: Int
    private(set) var thirdScore : Int
    
    static let shared = ScoreManager()
    
    func appendNewScore(_ score: Int) {
        allScore.append(score)
        sortedScore()
        saveScore()
    }
    
    private func sortedScore() {
        allScore.sort()
        self.firstScore = allScore.max() ?? 0
        self.secondScore = allScore.filter { $0 < self.firstScore }.max() ?? 0
        self.thirdScore = allScore.filter { $0 < self.secondScore }.max() ?? 0
    }
    
    private func saveScore() {
        defaults.set(allScore, forKey: "savedScore")
    }
    
    func reset() {
        allScore.removeAll()
        saveScore()
    }
    
   fileprivate init(){
        self.firstScore = 0
        self.secondScore = 0
        self.thirdScore = 0
        self.allScore = defaults.object(forKey:"savedScore") as? [Int] ?? [Int]()
        if !allScore.isEmpty { sortedScore() }
    }
    
}
