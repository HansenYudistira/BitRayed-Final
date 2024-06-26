//
//  CharacterNameBoxView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import SwiftUI

struct CharacterNameBoxView: View {
    
    let characterName: String
    let characterPosition: Alignment
    
    var body: some View {
        VStack (spacing: 0) {
            Text(characterName.uppercased())
                .frame(width: SizeConstant.fullWidth * 0.2, height: 50)
                .font(.custom("Dogica_bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .background(Color.black)
                .border(Color.white, width: 5)
        }
        .padding(.top, 230)
    }
}

#Preview {
    DialogBoxView(scene: [
        (1, "Why, Dan?", "Beth Gallagher", "Wife"),
        (2, "It's not what it looks like, Beth. Let me explain.", "Dan Gallagher", "Husband"),
        (1, "Explain? How do you explain cheating on me?", "Beth Gallagher", "Wife"),
        (2, "I made a mistake. It was a moment of weakness.", "Dan Gallagher", "Husband"),
        (1, "A moment?", "Beth Gallagher", "Wife"),
        (2, "Beth, please. I love you. We can work through this.", "Dan Gallagher", "Husband"),
        (1, "How could you do this to us? To me?", "Beth Gallagher", "Wife"),
        (2, "I never wanted to hurt you. I was stupid. Please, just give me a chance to make it right.", "Dan Gallagher", "Husband"),
        (1, "I don't know if I can ever forgive you for this.", "Beth Gallagher", "Wife")
    ], currentSceneIndex: .constant(1))
}
