//
//  FileCabinetView.swift
//  BitRayed
//
//  Created by Ali Haidar on 24/06/24.
//

import SwiftUI

struct FileCabinetView: View {
    
    @State private var offset: CGFloat = 0
    let maxHeight: CGFloat = 10
    let minHeight: CGFloat = -370
    
    @StateObject var gyroManager = PeekGyroManager()
    let folders = ["Folder 1", "Folder 2", "Folder 3", "Folder 4", "Folder 5"]
    
    @Environment(\.dismiss) private var dismiss
    let defaults = UserDefaults.standard
    
    @State private var foundFile = false
    
    
    @State private var showHint = false
    @State private var hintMessage = ""
    
    var body: some View {
        ZStack{
            Image("level2_bg")
                .interpolation(.none)
                .resizable()
                .ignoresSafeArea()
                .opacity(foundFile ? 0 : 1)
                .animation(.easeInOut(duration: 1), value: foundFile)
            
            if foundFile {
                Color.black
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1), value: foundFile)
            }
            
            ZStack{
                Drawer()
                    .opacity(foundFile ? 0 : 1)
                    .animation(.easeInOut(duration: 1), value: foundFile)
                
                ForEach(folders.indices, id: \.self) { index in
                    Image(folders[index])
                        .interpolation(.none)
                        .resizable()
                        .opacity(index == gyroManager.currentFolderIndex ? 1 : (foundFile ? 0 : 1))
                        .offset(CGSize(width: 0, height: index == gyroManager.currentFolderIndex ? -180 : 0))
                        .onTapGesture {
                            if gyroManager.currentFolderIndex == 0 {
                                print("File's found")
                                defaults.set(true, forKey: "Puzzle2_done")
                                defaults.synchronize()
                                if let soundURL = Bundle.main.url(forResource: "DrawerOpenSFX", withExtension: "wav") {
                                    AudioPlayer.playSound(url: soundURL, withID: "DrawerOpenSFX")
                                }
                                withAnimation {
                                    foundFile = true
                                }
                            } else {
                                print("Nothing in this file")
                            }
                        }
                }
                .offset(y: 50)
                
                Image("Front Drawer")
                    .interpolation(.none)
                    .resizable()
                    .allowsHitTesting(false)
                    .opacity(foundFile ? 0 : 1)
                    .animation(.easeInOut(duration: 1), value: foundFile)
                
                if showHint{
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
                
                VStack {
                    if foundFile {
                        VStack(spacing: 15){
                            Text("Threatning letter bla bla bla")
                                .font(.custom("dogica", size: 22))
                            
                            Button {
                                dismiss()
                            } label: {
                                Text("Close")
                                    .font(.custom("dogica", size: 20))
                                    .foregroundStyle(.black)
                                    .bold()
                                    .padding(55)
                                    .background(Image("button_template").resizable())
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25).foregroundStyle(.thinMaterial))
                        .transition(.opacity)
                    }
                }
                
                if !foundFile {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                    }
                    .position(CGPoint(x: 50, y: 50))
                    .zIndex(4)
                } else{
                    HintDialogBoxView(hintText: "Hmm looks suspicious. Bla bla look at painting")
                }
            }
            .ignoresSafeArea()
        }.onAppear{
            showHintWithMessage("TILT THE SCREEN TO THE FRONT TO HAVE A LITTLE LOOK INSIDE")
        }
    }
    private func showHintWithMessage(_ message: String) {
        hintMessage = message
        withAnimation {
            showHint = true
        }
    }
}

struct Drawer: View {
    var body: some View {
        ZStack {
            Image("Base Drawer")
                .interpolation(.none)
                .resizable()
                .frame(height: 500)
            
            Image("Back Drawer")
                .interpolation(.none)
                .resizable()
                .frame(height: 650)
            
            Image("Right Drawer")
                .interpolation(.none)
                .resizable()
                .position(CGPoint(x: 600, y: 400))
                .frame(height: 650)
            
            Image("Left Drawer")
                .interpolation(.none)
                .resizable()
                .position(CGPoint(x: 600, y: 400))
                .frame(height: 650)
        }
    }
}

#Preview {
    FileCabinetView()
}
