//
//  PeekGyroManager.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI
import CoreMotion
import AVFAudio

class PeekGyroManager: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var currentFolderIndex: Int = 4
    private var initialRoll: Double?
    private var inChangedState: Bool = false
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private let audioPlayer: AVAudioPlayer?
    
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.3
        if let soundURL = Bundle.main.url(forResource: "SearchFileSFX#1", withExtension: "wav") {
            audioPlayer = AudioPlayer.preloadAudioPlayer(url: soundURL)
        } else {
            audioPlayer = nil
        }
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                if let data = data {
                    self.checkRollChange(data.attitude.roll)
                }
            }
        }
        
        feedbackGenerator.prepare()
    }
    
    private func checkRollChange(_ currentRoll: Double) {
        if initialRoll == nil {
            initialRoll = currentRoll
        }
        
        if let initialRoll = initialRoll {
            let rollChange = currentRoll - initialRoll
            
            // Check if tilted backward by 10 degrees
            let degreeChange = rollChange * (180 / .pi)
            let folderIndexChange = Int(degreeChange / 30)
            
            if folderIndexChange != 0 {
                self.currentFolderIndex = max(0, min(4, self.currentFolderIndex - folderIndexChange))
                inChangedState = true
                
                audioPlayer?.play()
                feedbackGenerator.impactOccurred()
                feedbackGenerator.prepare()
            } else {
                inChangedState = false
            }
        }
    }
    
    deinit {
        self.motionManager.stopDeviceMotionUpdates()
    }
}
