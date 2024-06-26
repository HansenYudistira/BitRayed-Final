//
//  HoldableButton.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SwiftUI

struct HoldableButton: View {
    let imageName: String
    let onPress: () -> Void
    let onRelease: () -> Void
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
                    if isPressing {
                        onPress()
                    } else {
                        onRelease()
                    }
                }, perform: {})
            
        }
        
        
    }
}
