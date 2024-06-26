//
//  ButtonContent.swift
//  2dGameSafe
//
//  Created by Ali Haidar on 26/06/24.
//

import SwiftUI

struct ButtonContent: View {
    let label: String
    
    var body: some View {
        ZStack {
            Image("button_template")
                .resizable()
                .frame(width: 250, height: 100)
            Text(label)
                .font(.custom("dogica", size: 18))
                .foregroundStyle(.black)
        }
    }
}

//#Preview {
//    ButtonContent()
//}
