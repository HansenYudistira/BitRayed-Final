//
//  ShakeView.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI
import SpriteKit

struct ShakeView: View {
    @StateObject private var motionManager = ShakeMotionManager()
    @StateObject private var wardrobeShakeView = WardrobeShakeView(size: CGSize(width: 500, height: 500))
    @Environment(\.dismiss) private var dismiss
    let defaults = UserDefaults.standard

    var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                SpriteView(scene: wardrobeShakeView)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color.white)
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                }
                .position(CGPoint(x: 50, y: 50))
                .zIndex(4)

            }
            .onChange(of: wardrobeShakeView.hasTapped) {
                if wardrobeShakeView.hasTapped {
                    defaults.set(true, forKey: "Puzzle1_done")
                    dismiss()
                }
            }
            .onChange(of: motionManager.roll) {
                withAnimation(.spring()) {
                    wardrobeShakeView.rotationAngle = motionManager.roll
                }
            }.ignoresSafeArea()
        }
    
}

#Preview {
    ShakeView()
}
