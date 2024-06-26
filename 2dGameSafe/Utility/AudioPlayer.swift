//
//  AudioPlayer.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 24/06/24.
//

import AVFoundation

class AudioPlayer: ObservableObject {
    static var audioPlayers: [String: AVAudioPlayer] = [:]
    var backgroundPlayer: AVAudioPlayer?
    
    static func preloadAudioPlayer(url: URL) -> AVAudioPlayer? {
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            return audioPlayer
        } catch {
            print("Error initializing audio player:", error)
            return nil
        }
    }
    
    func playSoundBackground(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                backgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                backgroundPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundPlayer?.play()
                backgroundPlayer?.volume = 2
            } catch {
                print("Could not find and play the sound file.")
            }
        }
    }

    static func playSound(url: URL, withID id: String, loop: Bool = false) {
        guard let audioPlayer = preloadAudioPlayer(url: url) else {
            print("Failed to preload audio player for url:", url)
            return
        }
        
        audioPlayer.numberOfLoops = loop ? -1 : 0
        audioPlayer.play()
        audioPlayers[id] = audioPlayer
    }
    
    static func stopAllMusic() {
        for (_, audioPlayer) in audioPlayers {
            audioPlayer.stop()
        }
        audioPlayers.removeAll()
    }
    
    static func stopMusic(withID id: String) {
        if let audioPlayer = audioPlayers[id] {
            audioPlayer.stop()
            audioPlayers.removeValue(forKey: id)
        }
    }
    
    static func setVolume(forID id: String, volume: Float) {
        if let audioPlayer = audioPlayers[id] {
            audioPlayer.volume = volume
        }
    }
}
