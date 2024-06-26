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
    
//    var scene: SKScene = {
//        let scene = GameScene(fileNamed: "MainScene.sks")!
//        scene.scaleMode = .resizeFill
//        return scene
//    }()
    
    
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
                    VStack {
                        Spacer()
                        HoldableButton(imageName: "arrowshape.up.circle.fill") {
                            gameViewModel.gameScene?.moveUp = true
                        } onRelease: {
                            gameViewModel.gameScene?.moveUp = false
                        }
                        HStack (spacing: 100){
                            
                            HoldableButton(imageName: "arrowshape.left.circle.fill") {
                                gameViewModel.gameScene?.moveToLeft = true
                            } onRelease: {
                                gameViewModel.gameScene?.moveToLeft = false
                            }
                            
                            HoldableButton(imageName: "arrowshape.right.circle.fill") {
                                gameViewModel.gameScene?.moveToRight = true
                            } onRelease: {
                                gameViewModel.gameScene?.moveToRight = false
                            }
                            
                        }
                        
                        HoldableButton(imageName: "arrowshape.down.circle.fill") {
                            gameViewModel.gameScene?.moveDown = true
                        } onRelease: {
                            gameViewModel.gameScene?.moveDown = false
                        }
                        
                        
                    }
                    Spacer()
                    
                    VStack() {
                        TapButton(imageName: "a.circle.fill") {
                            gameViewModel.gameScene?.actionButton = true
                        }
                        
                        TapButton(imageName: "b.circle.fill") {
                            gameViewModel.gameScene?.possesButton = true
                        }
                    }
                    .offset(x: -100, y: 350)
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        }
    }
}



#Preview {
    MainGameView()
}
