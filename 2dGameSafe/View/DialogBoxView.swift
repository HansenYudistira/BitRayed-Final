//
//  DialogBoxView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import SwiftUI

struct DialogBoxView: View {
    
    let scene: [(Int, String, String, String)]
    @Binding var currentSceneIndex: Int 
    
    @State private var currentTextIndex: Int = 0
    @State private var displayedText: String = ""
    @State private var characterName: String = ""
    @State private var characterImage: String = ""
    @State private var currentIndex: Int = 0
    @State private var timer: Timer? = nil
    @State private var characterPosition: Alignment = .topLeading
    
    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 0) {
                if characterPosition == .topLeading {
                    CharacterBoxView(characterImage: characterImage)
                    
                    DialogTextView(displayedText: displayedText, characterName: characterName, characterPosition: characterPosition)
                } else {
                    DialogTextView(displayedText: displayedText, characterName: characterName, characterPosition: characterPosition)
                    
                    CharacterBoxView(characterImage: characterImage)
                        .scaleEffect(x: -1, y: 1)
                }
            }
            .onAppear {
                setupSceneInfo()
            }
        }
        .onAppear {
            if currentSceneIndex == 3 {
                if let ambience = Bundle.main.url(forResource: "HouseAmbienceSFX", withExtension: "wav") {
                    AudioPlayer.playSound(url: ambience, withID: "ambience", loop: true)
                    
                    AudioPlayer.setVolume(forID: "ambience", volume: 1.5)
                } 
            }
            
            else if currentSceneIndex == 7 || currentSceneIndex == 12 {
                if let ambience = Bundle.main.url(forResource: "RestaurantAmbienceSFX", withExtension: "wav") {
                    AudioPlayer.stopMusic(withID: "doorBell")
                    
                    AudioPlayer.playSound(url: ambience, withID: "ambience", loop: true)
                    
                    AudioPlayer.setVolume(forID: "ambience", volume: 1)
                }
            }
        }
        .onTapGesture {
            handleTap()
        }
        .frame(width: SizeConstant.boxWidth, height: 270)
        .padding(.top, SizeConstant.fullHeight * 0.61)
    }
    
    private func setupSceneInfo() {
        let currentText = scene[currentTextIndex]
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
        let fullText = scene[currentTextIndex].1
        displayedText = fullText
        currentIndex = fullText.count
    }
    
    private func handleTap() {
        if currentTextIndex >= scene.count {
            currentSceneIndex += 1
            return
        }
        
        if currentIndex < scene[currentTextIndex].1.count {
            showFullText()
        } else {
            currentTextIndex += 1
            
            if currentTextIndex < scene.count {
                displayedText = ""
                currentIndex = 0
                setupSceneInfo()
            } else {
                currentSceneIndex += 1
            }
        }
    }
}


struct DialogBoxView_Previews: PreviewProvider {
    static var previews: some View {
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
}

