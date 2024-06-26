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
    @State private var isLoading = false
    let defaults = UserDefaults.standard

    
    var body: some View {
        ZStack{
            RainfallView()
            
            VStack{
                
                Spacer()
                
                GlitchText()
                
                Spacer()
                
                Button(action: {
                    isLoading = true
                    isNewGame()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigateToGame = true
                        isLoading = false
                    }
                }) {
                    Text("New Game")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 24).frame(width: 250))
                }
                Button(action: {
                    defaults.set(false, forKey: "NewGame")
                }) {
                    Text("Continue")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 24).frame(width: 250))
                }
                Button(action: {
                    
                }) {
                    Text("Credits")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 24).frame(width: 250))
                }
                Button(action: {
                    exit(0)
                }) {
                    Text("Exit")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 24).frame(width: 250))
                }
                
                Spacer()
            }
            
            if isLoading {
                LoadingView()
            }
        }
        
        .onAppear{
            audioPlayer.playSound(sound: "main_music", type: "wav")
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

//#Preview {
//    StartView()
//}
