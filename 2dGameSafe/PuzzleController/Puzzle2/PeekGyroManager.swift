//
//  PeekGyroManager.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI
import CoreMotion

class PeekGyroManager: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var currentFolderIndex: Int = 4
    private var initialRoll: Double?
    private var inChangedState: Bool = false
    
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.3
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                if let data = data {
                    self.checkRollChange(data.attitude.roll)
                }
            }
        }
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
            } else {
                inChangedState = false
            }
        }
    }
    
    deinit {
        self.motionManager.stopDeviceMotionUpdates()
    }
}
