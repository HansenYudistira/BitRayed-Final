//
//  NarrativeSceneView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import SwiftUI

struct NarrativeSceneView: View {
    
    let narrativeText: String
    @Binding var currentSceneIndex: Int 
    
    @State private var currentTextIndex: Int = 0
    @State private var displayedText: String = ""
    @State private var timer: Timer? = nil
    @State private var isTextFullyDisplayed: Bool = false
    
    var body: some View {
        VStack (spacing: 0) {
            Text(displayedText)
                .frame(width: SizeConstant.fullWidth * 0.7, height: 250)
                .font(.custom("Dogica", size: 23))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .lineSpacing(20)
        }
        .onAppear {
            AudioPlayer.stopMusic(withID: "ambience")
            
            if currentSceneIndex == 13 {
                AudioPlayer.stopMusic(withID: "backgroundMusic")
            }
            
            else if currentSceneIndex == 14 {
                if let backgroundMusic = Bundle.main.url(forResource: "NarrativeAmbienceSFX", withExtension: "wav") {
                    AudioPlayer.playSound(url: backgroundMusic, withID: "backgroundMusic", loop: true)
                    
                    AudioPlayer.setVolume(forID: "backgroundMusic", volume: 0.9)
                }
            }
            
            resetState()
            
            startTypewriterEffect()
         }
        .frame(width: SizeConstant.fullWidth, height: SizeConstant.fullHeight)
        .background(.black)
        .onTapGesture {
            handleTap()
        }
    }
    
    private func resetState() {
        displayedText = ""
        currentTextIndex = 0
        timer?.invalidate()
        isTextFullyDisplayed = false
    }
    
    private func startTypewriterEffect() {
        isTextFullyDisplayed = false
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.currentTextIndex < self.narrativeText.count {
                let index = self.narrativeText.index(self.narrativeText.startIndex, offsetBy: self.currentTextIndex)
                self.displayedText.append(self.narrativeText[index])
                self.currentTextIndex += 1
                if let narrativeTalking = Bundle.main.url(forResource: "NarrativeTalkingSFX", withExtension: "wav") {
                    AudioPlayer.playSound(url: narrativeTalking, withID: "narrativeTalking", loop: false)
                    
                    AudioPlayer.setVolume(forID: "narrativeTalking", volume: 0.1)
                }
            } else {
                timer.invalidate()
                isTextFullyDisplayed = true
            }
        }
    }
    
    private func showFullText() {
        timer?.invalidate()
        displayedText = narrativeText
        currentTextIndex = narrativeText.count
        isTextFullyDisplayed = true
    }
    
    private func handleTap() {
        if isTextFullyDisplayed {
            currentSceneIndex += 1
        } else {
            showFullText()
        }
    }
}

#Preview {
    NarrativeSceneView(narrativeText: "Determined to get revenge, I looked for my best friend, a woman I had been close to for a long time.", currentSceneIndex: .constant(1))
}
