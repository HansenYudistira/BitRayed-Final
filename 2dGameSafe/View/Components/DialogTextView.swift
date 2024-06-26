//
//  DialogTextView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import SwiftUI

struct DialogTextView: View {
    
    let displayedText: String
    let characterName: String
    let characterPosition: Alignment
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing: 0) {
                Spacer().frame(height: 5)
                
                Text(characterName.uppercased())
                    .font(.custom("Dogica_bold", size: 21))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .frame(width: SizeConstant.fullWidth * 0.67, height: 35, alignment: characterPosition == .topLeading ? .leading : .trailing)
                
                Spacer().frame(height: 10)
                
                Text(displayedText)
                    .font(.custom("Dogica", size: 23))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .lineSpacing(10)
                    .frame(width: SizeConstant.fullWidth * 0.67, height: 150, alignment: characterPosition)
                
                Spacer().frame(height: 5)
            }
        }
        .frame(width: SizeConstant.boxWidth * 0.75, height: 220)
        .border(.darkerGray, width: 10)
        .border(.gray, width: 5)
        .background(.darkerWhite)
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
