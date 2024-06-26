//
//  SceneView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import SwiftUI

struct SceneView: View {
    
    @State private var currentSceneIndex = 0
    @State var isFinished = false

    var body: some View {
        VStack (spacing: 0) {
            ZStack {                
                if ScenesData.scenes.count != currentSceneIndex {
                    Group {
                        switch ScenesData.scenes[currentSceneIndex] {
                        case .narrative(let text):
                            NarrativeSceneView(narrativeText: text, currentSceneIndex: $currentSceneIndex)
                        case .dialogue(let dialogue):
                            Image(backgroundImageForDialogue())
                                .resizable()
                                .frame(width: 300, height: 300)
                                .aspectRatio(contentMode: .fit)
                            
                            DialogBoxView(scene: dialogue, currentSceneIndex: $currentSceneIndex)
                        case .blackScreen(let dialogue):
                            BlackScreenView(text: dialogue, currentSceneIndex: $currentSceneIndex)
                        }
                    }
                    .id(currentSceneIndex)
                }
            }
        }
        .onAppear {
            if let backgroundMusic = Bundle.main.url(forResource: "Music1", withExtension: "wav") {
                AudioPlayer.playSound(url: backgroundMusic, withID: "backgroundMusic", loop: true)
                
                AudioPlayer.setVolume(forID: "backgroundMusic", volume: 0.7)
            }
        }
        .frame(width: SizeConstant.fullWidth, height: SizeConstant.fullHeight)
        .background(.black)
        .onChange(of: currentSceneIndex, { oldValue, newValue in
            if newValue == ScenesData.scenes.count {
                isFinished = true
            }
        })
        .navigationDestination(isPresented: $isFinished) {
            MainGameView()
                .navigationBarBackButtonHidden()
        }
    }
    
    private func backgroundImageForDialogue() -> String {
        switch currentSceneIndex {
        case 3:
            return "WifeHusband"
        case 7:
            return "WifeBestFriend"
        case 12:
            return "WifeBestFriend"
        default:
            return ""
        }
    }
}

#Preview {
    SceneView()
}
