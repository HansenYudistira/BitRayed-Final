//
//  AudioPlayer.swift
//  BitRayed
//
//  Created by Ali Haidar on 23/06/24.
//

import AVFoundation

class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?

    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.numberOfLoops = -1 // Loop indefinitely
                player?.play()
            } catch {
                print("Could not find and play the sound file.")
            }
        }
    }
}
