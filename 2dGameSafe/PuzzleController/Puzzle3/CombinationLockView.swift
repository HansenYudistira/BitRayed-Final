//
//  CombinationLockView.swift
//  BitRayed
//
//  Created by Ali Haidar on 24/06/24.
//

import SwiftUI

struct CombinationLockView: View {
    
    let leftArray = ["1 Left", "2. Left", "3 Left", "4 Left", "5 Left"]
    let midArray = ["1 Mid", "2. Mid", "3 Mid", "4 Mid", "5 Mid"]
    let rightArray = ["1 Right", "2. Right", "3 Right", "4 Right", "5 Right"]
    
    @State private var leftIndex = 0
    @State private var midIndex = 0
    @State private var rightIndex = 0
    
    @Environment(\.dismiss) private var dismiss
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            Image("level3_bg")
                .interpolation(.none)
                .resizable()
            
            HStack (spacing: -15) {
                CustomScrollView(images: leftArray, currentIndex: $leftIndex)
                CustomScrollView(images: midArray, currentIndex: $midIndex)
                CustomScrollView(images: rightArray, currentIndex: $rightIndex)
            }
            
            VStack {
                Spacer()
                Button {
                    print("left \(leftIndex), mid \(midIndex), right \(rightIndex)")
                    defaults.set(true, forKey: "Puzzle3_done")
                } label: {
                    Text("Unlock")
                        .font(.largeTitle)
                        .bold()
                }
            }.padding()
            
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
        .ignoresSafeArea()
    }
}

struct CustomScrollView: View {
    let images: [String]
    @Binding var currentIndex: Int
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<5) { index in
                    GeometryReader { geometry in
                        Image(images[index])
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 250, height: 445)
                            .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                                //                                    .rotation3DEffect(.degrees(phase.isIdentity ? 0 : (1 - phase.value) * 90), axis: (x: 1, y: 0, z: 0))
                            }
                            .onAppear {
                                let frame = geometry.frame(in: .global)
                                let scrollViewHeight = UIScreen.main.bounds.height
                                if frame.minY >= 0 && frame.minY <= scrollViewHeight / 2 && currentIndex != index {
                                    DispatchQueue.main.async {
                                        currentIndex = index
                                    }
                                }
                            }
                    }
                    .frame(width: 250, height: 445)
                }
            }
            .scrollTargetLayout()
        }
        .frame(width: 250, height: 450)
        .scrollTargetBehavior(.viewAligned)
        .padding(.bottom, 50)
    }
}

#Preview {
    CombinationLockView()
}
