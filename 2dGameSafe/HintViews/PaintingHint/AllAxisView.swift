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
            Image("PaintingHint")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            HintNumber()
            
            ZStack{
                Image("PaintingHint")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                .ignoresSafeArea()
                
                Color.black.opacity(0.5)
            }
                .reverseMask {
                    Circle()
                        .frame(width: 250, height: 200)
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

struct HintNumber: View {
    var body: some View {
        VStack{
            HStack(spacing:-5){
                Image("I")
                    .resizable()
                    .frame(width: 50, height: 50)
                Image("I")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Spacer()
            
            HStack(spacing:-5){
                Spacer()
                Image("V")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Spacer()
            HStack(spacing:-5){
                Image("I")
                    .resizable()
                    .frame(width: 70, height: 70)
                Image("V")
                    .resizable()
                    .frame(width: 70, height: 70)
                Spacer()
            }
        }
        .padding(90)
    }
}
