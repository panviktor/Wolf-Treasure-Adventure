//
//  AVAudio.swift
//  Angelica Fighti
//
//  Created by Guan Wong on 6/3/17.
//  Copyright © 2017 Wong. All rights reserved.
//

import SpriteKit
import AVFoundation

class AudioVibroManager {
    enum SoundType{
        case coin
        case puff
    }
    
    enum BackgroundSoundType{
        case backgroundStart
    }
    private let defaults = UserDefaults.standard
    private var musicStatus: Bool {
        get {
            return defaults.object(forKey: "musicStatus") as? Bool ?? true
        } set (newValue) {
            defaults.set(newValue, forKey: "musicStatus")
        }
    }
    
    private var vibroStatus: Bool {
        get {
            return defaults.object(forKey: "vibroStatus") as? Bool ?? true
        } set (newValue) {
            defaults.set(newValue, forKey: "vibroStatus")
        }
    }
    
    static let shared = AudioVibroManager()
    
    var backgroundMusic: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource: "begin", withExtension: "m4a") else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    fileprivate init() {}
    
    private func playMusic() {
        DispatchQueue.main.async {
            self.backgroundMusic?.play()
        }
    }
    
    func musicToggle() {
        musicStatus.toggle()
        musicStatus == true ? playMusic() : backgroundMusic?.stop()
    }
    
    func vibroToggle() {
        vibroStatus.toggle()
    }
    
    func play(type: BackgroundSoundType) {
        switch type {
        case .backgroundStart:
            if musicStatus {
                playMusic()
            }
        }
    }
    
    func getAction(type: SoundType) -> SKAction{
        switch type {
        case .coin:
            let skCoinAction = SKAction.playSoundFileNamed("getcoin.m4a", waitForCompletion: true)
            vibroStatus ? UIDevice.vibrate() : ()
            return skCoinAction
        case .puff:
            let skPuffAction = SKAction.playSoundFileNamed("puff.m4a", waitForCompletion: true)
            return skPuffAction
        }
    }
    
    func stop(){
        backgroundMusic?.stop()
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
