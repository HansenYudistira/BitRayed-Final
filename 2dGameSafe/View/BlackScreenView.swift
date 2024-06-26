//
//  BlackScreenView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 24/06/24.
//

import SwiftUI

struct BlackScreenView: View {
    
    let text: String
    @Binding var currentSceneIndex: Int 
    
    var body: some View {
        VStack (spacing : 0) {
            Text(text.uppercased())
                .frame(width: SizeConstant.fullWidth * 0.7, height: 250)
                .font(.custom("Dogica", size: 32))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .lineSpacing(20)
        }
        .onAppear {
            if currentSceneIndex == 2 {
                if let faceSlap = Bundle.main.url(forResource: "FaceSlapSFX", withExtension: "wav") {
                    AudioPlayer.playSound(url: faceSlap, withID: "faceSlap", loop: false)
                    
                    AudioPlayer.setVolume(forID: "faceSlap", volume: 0.2)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        currentSceneIndex += 1
                    }
                }
            }
            
            else if currentSceneIndex == 6 || currentSceneIndex == 11 {
                if let bell = Bundle.main.url(forResource: "DoorBellOpenSFX", withExtension: "wav") {
                    AudioPlayer.playSound(url: bell, withID: "bell", loop: false)
                    
                    AudioPlayer.setVolume(forID: "bell", volume: 0.1)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        currentSceneIndex += 1
                    }
                }
            }
            
            else if currentSceneIndex == 18 {
                if let knifeStab = Bundle.main.url(forResource: "KnifeStabSFX", withExtension: "wav") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        AudioPlayer.stopMusic(withID: "backgroundMusic")
                        AudioPlayer.playSound(url: knifeStab, withID: "knifeStab", loop: false)
                    }
                    
                    AudioPlayer.setVolume(forID: "knifeStab", volume: 0.7)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        currentSceneIndex += 1
                    }
                }
            } 
            
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    currentSceneIndex += 1
                }
            }
        }
        .frame(width: SizeConstant.fullWidth, height: SizeConstant.fullHeight)
        .background(.black)
    }
}

#Preview {
    BlackScreenView(text: "One Month Later",currentSceneIndex: .constant(4))
}
