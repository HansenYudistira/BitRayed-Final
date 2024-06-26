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
    
    @StateObject var gameState = GameState()
    @StateObject var gameViewModel = GameViewModel()
    @State private var scene: GameScene? = nil
    
    
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
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        }.onAppear{
            defaults.synchronize()
        }
    }
}


#Preview {
    MainGameView()
}
