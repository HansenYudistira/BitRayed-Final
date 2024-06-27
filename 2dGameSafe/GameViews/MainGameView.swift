//
//  MainGameView.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SwiftUI
import SpriteKit

class GameViewModel: ObservableObject {
    let gameScene: GameScene?
    
    init() {
        let newScene = GameScene(fileNamed: "MainScene 2.sks")!
        newScene.scaleMode = .resizeFill
        gameScene = newScene
    }
}

struct MainGameView: View {
    
    let defaults = UserDefaults.standard
    
    @State private var moveToLeft = false
    @State private var moveToRight = false
    
    @State private var showDialog = true

    
    @StateObject var gameState = GameState()
    @StateObject var gameViewModel = GameViewModel()
    @State private var scene: GameScene? = nil
    
    
    @State private var showHint = false
    @State private var hintMessage = ""
    
    var body: some View {
        VStack {
            ZStack {
                RainfallView()
                //            SpriteView(scene: scene)
                if let scene = gameViewModel.gameScene {
                    SpriteView(scene: scene)
                        .id(1)
                        .onAppear {
                            print("Scene appeared")
                            scene.gameState = gameState
                            scene.showHint = { message in
                                showHintWithMessage(message)
                            }
                        }
                }
                
                HStack {
                    VStack (spacing: -45){
                        Spacer()
                        HoldableButton(imageName: "up") {
                            gameViewModel.gameScene?.moveUp = true
                        } onRelease: {
                            gameViewModel.gameScene?.moveUp = false
                        }
                        HStack (spacing: 0){
                            
                            HoldableButton(imageName: "left") {
                                gameViewModel.gameScene?.moveToLeft = true
                            } onRelease: {
                                gameViewModel.gameScene?.moveToLeft = false
                            }
                            
                            HoldableButton(imageName: "right") {
                                gameViewModel.gameScene?.moveToRight = true
                            } onRelease: {
                                gameViewModel.gameScene?.moveToRight = false
                            }
                            
                        }
                        
                        HoldableButton(imageName: "down") {
                            gameViewModel.gameScene?.moveDown = true
                        } onRelease: {
                            gameViewModel.gameScene?.moveDown = false
                        }
                        
                        
                    }
                    Spacer()
                    
                    VStack() {
                        TapButton(imageName: "action") {
                            gameViewModel.gameScene?.actionButton = true
                        }
                        
                        TapButton(imageName: "posses") {
                            gameViewModel.gameScene?.possesButton = true
                        }
                    }
                    .offset(x: 0, y: 300)
                }
                .padding()
                
                InventoryItem()
                
                if defaults.bool(forKey: "NewGame"){
                    HintDialogBoxView(hintText: "AM I DEAD?! \nAM I A GHOST NOW?! \nI HAVE TO FIND WHO DID THIS TO ME!")
                }
                
                if showHint {
                    HintDialogBoxView(hintText: hintMessage)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showHint = false
                                }
                            }
                        }
                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        }.onAppear{
            defaults.synchronize()
        }
    }
    
    private func showHintWithMessage(_ message: String) {
        hintMessage = message
        withAnimation {
            showHint = true
        }
    }
}



#Preview {
    MainGameView()
}
