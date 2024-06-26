//
//  GyroManager.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI
import CoreMotion

class GyroManager: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var lookAtPoint: CGPoint = .zero
    
    private var currentX: Double = 0.0
    private var currentY: Double = 0.0
    
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.gyroUpdateInterval = 0.1
        
        if self.motionManager.isGyroAvailable {
            self.motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                if let data = data {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y
                    self.updateLookAtPoint(x: x, y: y)
                }
            }
        }
    }
    
    private func updateLookAtPoint(x: Double, y: Double) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let centerX = screenWidth / 2
        let centerY = screenHeight / 2
        
        // Accumulate the changes
        currentX += x * 100
        currentY += y * 100
        
        // Clamp to screen bounds
        currentX = min(max(currentX, -centerX), centerX)
        currentY = min(max(currentY, -centerY), centerY)
        
        let newX = centerX + CGFloat(currentX)
        let newY = centerY - CGFloat(currentY)
        
        DispatchQueue.main.async {
            self.lookAtPoint = CGPoint(x: newX, y: newY)
        }
    }
    
    deinit {
        self.motionManager.stopGyroUpdates()
    }
}
