//
//  ShakeMotionManager.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI
import CoreMotion

class ShakeMotionManager: ObservableObject {
    private var motionManager: CMMotionManager
    
    @Published var roll: Double = 0.0
    
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.1
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                if let data = data {
                    let roll = data.attitude.pitch
                    self.roll = roll
                }
            }
        }
    }
    
    deinit {
        self.motionManager.stopDeviceMotionUpdates()
    }
}
