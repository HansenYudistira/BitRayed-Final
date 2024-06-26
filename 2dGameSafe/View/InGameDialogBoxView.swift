//
//  InGameDIalogBox.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 26/06/24.
//

import SwiftUI

struct InGameDialogBoxView: View {
    
    let dialogText: [(Int, String, String, String)]
    @Binding var dismissed: Bool
    
    @State private var currentTextIndex: Int = 0
    @State private var displayedText: String = ""
    @State private var characterName: String = ""
    @State private var characterImage: String = ""
    @State private var currentIndex: Int = 0
    @State private var timer: Timer? = nil
    @State private var characterPosition: Alignment = .topLeading
    
    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing : 0) {
                HStack (spacing: 0) {
                    HStack (spacing: 0) {
                        Image("Wife2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: SizeConstant.boxWidth * 0.25, height: 270)
                    .border(.darkerGray, width: 10)
                    .border(.gray, width: 5)
                    .border(.black, width: 2)
                    .background(.darkerWhite)
                    
                    VStack (spacing: 0) {
                        Spacer().frame(height: 5)
                        
                        Text("Beth Gallagher")
                            .font(.custom("Dogica_bold", size: 21))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.black)
                            .frame(width: SizeConstant.fullWidth * 0.67, height: 35, alignment: .leading)
                        
                        Spacer().frame(height: 10)
                        
                        Text(displayedText)
                            .font(.custom("Dogica", size: 23))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.black)
                            .lineSpacing(10)
                            .frame(width: SizeConstant.fullWidth * 0.67, height: 150, alignment: .topLeading)
                        
                        Spacer().frame(height: 5)
                    }
                    .frame(width: SizeConstant.boxWidth * 0.75, height: 220)
                    .border(.darkerGray, width: 10)
                    .border(.gray, width: 5)
                    .background(.darkerWhite)
                }
                .onAppear {
                    setupSceneInfo()
                }
                .onTapGesture {
                    handleTap()
                }
            }
            .frame(width: SizeConstant.boxWidth, height: 270)
            .padding(.top, SizeConstant.fullHeight * 0.61)
        }
        .frame(width: SizeConstant.fullWidth, height: SizeConstant.fullHeight)
        .background(.clear)
    }
    
    private func setupSceneInfo() {
        let currentText = dialogText[currentTextIndex]
        let fullText = currentText.1
        let name = currentText.2
        let image = currentText.3
        
        characterName = name
        characterImage = image
        
        if currentText.0 / 2 == 0 {
            characterPosition = .topLeading
        } else {
            characterPosition = .topTrailing
        }
        
        startTypewriterEffect(fullText: fullText)
    }
    
    private func startTypewriterEffect(fullText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: self.currentIndex)
                
                self.displayedText.append(fullText[index])
                
                self.currentIndex += 1
                
                if characterImage == "Wife1" || characterImage == "Wife2" {
                    if let wifeTalking = Bundle.main.url(forResource: "WifeTalkingSFX", withExtension: "wav") {
                        AudioPlayer.playSound(url: wifeTalking, withID: "wifeTalking", loop: false)
                        
                        AudioPlayer.setVolume(forID: "wifeTalking", volume: 0.1)
                    }
                }
                
                else if characterImage == "BestFriend" {
                    if let bestFriendTalking = Bundle.main.url(forResource: "BestFriendTalkingSFX", withExtension: "wav") {
                        AudioPlayer.playSound(url: bestFriendTalking, withID: "bestFriendTalking", loop: false)
                        
                        AudioPlayer.setVolume(forID: "bestFriendTalking", volume: 0.1)
                    }
                }
                
                else if characterImage == "Husband" {
                    if let husbandTalking = Bundle.main.url(forResource: "HusbandTalkingSFX", withExtension: "wav") {
                        AudioPlayer.playSound(url: husbandTalking, withID: "husbandTalking", loop: false)
                        
                        AudioPlayer.setVolume(forID: "husbandTalking", volume: 0.1)
                    }
                }
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func showFullText() {
        timer?.invalidate()
        let fullText = dialogText[currentTextIndex].1
        displayedText = fullText
        currentIndex = fullText.count
    }
    
    private func handleTap() {
        if currentTextIndex >= dialogText.count {
            dismissed = true
        }
        
        if currentIndex < dialogText[currentTextIndex].1.count {
            showFullText()
        } else {
            currentTextIndex += 1
            
            if currentTextIndex < dialogText.count {
                displayedText = ""
                currentIndex = 0
                setupSceneInfo()
            } else {
                dismissed = true
            }
        }
    }
}

#Preview {
    InGameDialogBoxView(dialogText: [
        (1, "Why, Dan?", "Beth Gallagher", "Wife"),
        (1, "Why, Dan?", "Beth Gallagher", "Wife")
    ], dismissed: .constant(false))
}
