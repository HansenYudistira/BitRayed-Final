//
//  StartView.swift
//  BitRayed
//
//  Created by Ali Haidar on 23/06/24.
//

import SwiftUI
import AVFoundation

struct StartView: View{
    
    @StateObject private var audioPlayer = AudioPlayer()
    @State var navigateToGame = false
    @State var navigateToScene = false
    @State private var isLoading = false
    let defaults = UserDefaults.standard

    var body: some View {
        ZStack{
//            RainfallView()
            RepeatingTile(tileImage: Image("start_tile")).ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
//                GlitchText()
                Text("BITRAYED")
                    .font(.custom("dogica", size: 69))
                    .bold()
                    .foregroundStyle(.white)
                
                Spacer()
                
                Group {
                    Button(action: {
                        isLoading = true
                        isNewGame()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            navigateToScene = true
                            isLoading = false
                        }
                    }) {
                        ButtonContent(label: "New Game")
                    }
                    
                    Button(action: {
                        isLoading = true
                        defaults.set(false, forKey: "NewGame")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            navigateToGame = true
                            isLoading = false
                        }
                    }) {
                        ButtonContent(label: "Continue")
                    }
                    
                    Button(action: {
                        
                    }) {
                        ButtonContent(label: "Credits")
                    }
                }

//                Button(action: {
//                    exit(0)
//                }) {
//                    Text("Exit")
//                        .font(.title2)
//                        .foregroundStyle(.white)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 24).frame(width: 250))
//                }
                
                Spacer()
            }
            
            if isLoading {
                LoadingView()
            }
        }
        
        .onAppear{
            audioPlayer.playSoundBackground(sound: "main_music", type: "wav")
        }
        .navigationDestination(isPresented: $navigateToScene){
            SceneView()
        }
        .navigationDestination(isPresented: $navigateToGame){
            MainGameView()
        }
        
    }
    
    func isNewGame(){
        defaults.set(true, forKey: "NewGame")
        defaults.set(false, forKey: "Puzzle1_done")
        defaults.set(false, forKey: "Puzzle2_done")
        defaults.set(false, forKey: "Puzzle3_done")
        defaults.set(false, forKey: "Puzzle4_done")
        defaults.set(false, forKey: "Puzzle5_done")
        defaults.set(false, forKey: "Puzzle6_done")
    }
}

struct RepeatingTile: View {
    let tileImage: Image

    init(tileImage: Image) {
        self.tileImage = tileImage
    }

    var body: some View {
        GeometryReader { geometry in
            tileImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 128, height: 128)
                .offset(x: 0, y: 0)
                .repeatTile(geometry: geometry)
        }
    }
}

extension View {
    func repeatTile(geometry: GeometryProxy) -> some View {
        self
            .clipped()
            .overlay(
                GeometryReader { geo in
                    ForEach(0..<20) { x in
                        ForEach(0..<20) { y in
                            self
                                .offset(x: CGFloat(x) * 128, y: CGFloat(y) * 128)
                        }
                    }
                }
            )
    }
}
