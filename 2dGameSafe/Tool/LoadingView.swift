//
//  LoadingView.swift
//  BitRayed
//
//  Created by Ali Haidar on 23/06/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .foregroundColor(.white)
            }
            .padding(50)
            .background(Color.black)
            .cornerRadius(10)
        }
    }
}

#Preview {
    LoadingView()
}
