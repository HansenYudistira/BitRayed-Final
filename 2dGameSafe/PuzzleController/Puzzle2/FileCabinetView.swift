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
    
    var body: some View {
        ZStack{
            Image("level2_bg")
                .interpolation(.none)
                .resizable()
                .ignoresSafeArea()
            //            FolderRegular()
            //                .offset(y: offset)
            //                .animation(.spring(), value: offset)
            //                .gesture(DragGesture().onChanged({ value in
            //                    let newOffset = offset + value.translation.height
            //                    offset = min(max(newOffset, minHeight), maxHeight)
            //                }).onEnded({ _ in
            //                    offset = 0
            //                }))
            
            ZStack{
                //                Color.black
                Drawer()
                ForEach(folders.indices, id: \.self) { index in
                    Image(folders[index])
                        .interpolation(.none)
                        .resizable()
                    //                        .opacity(index == gyroManager.currentFolderIndex ? 1 : 0)
                        .offset(CGSize(width: 0, height: index == gyroManager.currentFolderIndex ? -180 : 0))
                        .onTapGesture {
                            if gyroManager.currentFolderIndex == 0 {
                                print("File's found")
                                defaults.set(true, forKey: "Puzzle2_done")
                                if let soundURL = Bundle.main.url(forResource: "DrawerOpenSFX", withExtension: "wav") {
                                    AudioPlayer.playSound(url: soundURL, withID: "DrawerOpenSFX")
                                }
                                defaults.synchronize()
                            }else{
                                print("Nothing in this file")
                            }
                        }
                }.offset(y: 50)
                
                Image("Front Drawer")
                    .interpolation(.none)
                    .resizable()
                    .allowsHitTesting(false)
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                }
                .position(CGPoint(x: 50, y: 50))
                .zIndex(4)
            }
            .ignoresSafeArea()
        }
    }
    
}



struct Drawer: View{
    var body: some View{
        ZStack{
            
            Image("Base Drawer")
                .interpolation(.none)
                .resizable()
                .frame(height: 500)
            
            Image("Back Drawer")
                .interpolation(.none)
                .resizable()
                .frame(height: 650)
            
            Image("Right  Drawer")
                .interpolation(.none)
                .resizable()
                .position(CGPoint(x: 600, y: 400))
                .frame(height: 650)
            
            Image("Left  Drawer")
                .interpolation(.none)
                .resizable()
                .position(CGPoint(x: 600, y: 400))
                .frame(height: 650)
            
            
        }
    }
}

struct FolderRegular: View{
    var body: some View{
        Drawer()
        ZStack{
            Image("Folder 1")
                .interpolation(.none)
                .resizable()
            Image("Folder 2")
                .interpolation(.none)
                .resizable()
            Image("Folder 3")
                .interpolation(.none)
                .resizable()
            Image("Folder 4")
                .interpolation(.none)
                .resizable()
            Image("Folder 5")
                .interpolation(.none)
                .resizable()
        }
        
        Image("Front Drawer")
            .interpolation(.none)
            .resizable()
    }
}

#Preview {
    FileCabinetView()
}
