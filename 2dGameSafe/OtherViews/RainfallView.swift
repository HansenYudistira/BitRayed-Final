//
//  RainfallView.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SwiftUI

struct Raindrop: View {
    var body: some View {
        Capsule()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.8), Color.white.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .frame(width: 2, height: 40)
            .rotationEffect(.degrees(10))
    }
}

struct RainfallView: View {
    let numberOfDrops = 100
    @State private var animate = false

    var body: some View {
        ZStack {
            Color.black
            ForEach(0..<numberOfDrops, id: \.self) { _ in
                Raindrop()
                    .offset(x: CGFloat.random(in: -500...500), y: animate ? 800 : -800)
                    .animation(
                        .linear(duration: Double.random(in: 1.0...2.0))
                        .repeatForever(autoreverses: false)
                        .delay(Double.random(in: 0...5)),
                        value: animate
                    )
                    .rotationEffect(.degrees(-45))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                self.animate = true
            }
        }
    }
}

#Preview {
    RainfallView()
}
