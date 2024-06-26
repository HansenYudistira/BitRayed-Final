//
//  GlitchText.swift
//  BitRayed
//
//  Created by Ali Haidar on 23/06/24.
//

import SwiftUI

struct GlitchText: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Text("BitRayed")
                .font(.custom("dogica", size: 69))
                .bold()
                .foregroundColor(.red)
                .offset(x: animate ? -2 : 2, y: animate ? 2 : -2)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true).delay(0.05), value: animate)

            Text("BitRayed")
                .font(.custom("dogica", size: 69))
                .bold()
                .foregroundColor(.white)
                .offset(x: animate ? 5 : -5, y: animate ? -5 : 5)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true).delay(0.1), value: animate)
        }
        .onAppear {
            self.animate = true
        }
    }
}

#Preview {
    GlitchText()
}
