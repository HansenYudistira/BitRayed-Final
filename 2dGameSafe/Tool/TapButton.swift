//
//  TapButton.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 24/06/24.
//

import SwiftUI

struct TapButton: View {
    let imageName: String
    let onPress: () -> Void
    
    var body: some View {
        Button(action: {
            onPress()
        }) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}
