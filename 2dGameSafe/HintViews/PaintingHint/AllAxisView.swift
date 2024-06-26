//
//  AllAxisView.swift
//  GyroTest
//
//  Created by Ali Haidar on 13/06/24.
//

import SwiftUI

struct AllAxisView: View {
    @StateObject private var gyroManager = GyroManager()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Image("paper")
                .resizable()
                .ignoresSafeArea()
            
            Color.black
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .reverseMask {
                    Image(systemName: "eye.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(
                            Circle()
                                .fill(.green)
                                .frame(width: 250, height: 200)
                        )
                        .position(gyroManager.lookAtPoint)
                        .zIndex(1)
                        .animation(Animation.easeInOut(duration: 1.2), value: gyroManager.lookAtPoint)
                }
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
    }
}

extension View {
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}

#Preview {
    AllAxisView()
}
