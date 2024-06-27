//
//  CombinationLockView.swift
//  BitRayed
//
//  Created by Ali Haidar on 24/06/24.
//

import SwiftUI

import SwiftUI

struct CombinationLockView: View {
    
    let leftArray = ["1 Left", "2. Left", "3 Left", "4 Left", "5 Left"]
    let midArray = ["1 Mid", "2. Mid", "3 Mid", "4 Mid", "5 Mid"]
    let rightArray = ["1 Right", "2. Right", "3 Right", "4 Right", "5 Right"]
    
    @State private var leftIndex: Int? = 0
    @State private var midIndex: Int? = 0
    @State private var rightIndex: Int? = 0
    @State private var correctCodeEntered = false
    @State private var showLoveLetterText = false
    
    @Environment(\.dismiss) private var dismiss
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            Image("level3_bg")
                .interpolation(.none)
                .resizable()
                .ignoresSafeArea()
            
            if correctCodeEntered {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                VStack {
                    if showLoveLetterText {
                        VStack(spacing: 15){
                            Text("Love letter bla bla bla")
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
                    } else {
                        Image("loveLetter")
                            .interpolation(.none)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 1.5)
                            .onTapGesture {
                                withAnimation {
                                    showLoveLetterText.toggle()
                                }
                            }
                    }
                }
                .zIndex(3)
            } else {
                HStack (spacing: -15) {
                    CodeScrollView(images: leftArray, scrolledID: $leftIndex)
                    CodeScrollView(images: midArray, scrolledID: $midIndex)
                    CodeScrollView(images: rightArray, scrolledID: $rightIndex)
                }
                VStack {
                    Spacer()
                    Button {
                        print("left \(leftIndex!), mid \(midIndex!), right \(rightIndex!)")
                        if(leftIndex == 3 && midIndex == 1 && rightIndex == 4 ){
                            defaults.set(true, forKey: "Puzzle3_done")
                            print("Correct")
                            withAnimation {
                                correctCodeEntered = true
                            }
                        } else {
                            print("Wrong")
                        }
                    } label: {
                        Text("Unlock")
                            .font(.custom("dogica", size: 20))
                            .foregroundStyle(.black)
                            .bold()
                            .padding(55)
                            .background(Image("button_template").resizable())
                    }
                }.padding(10)
                
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
        }
    }
}

struct CodeScrollView: View {
    let images: [String]
    @Binding var scrolledID: Int?
    var body: some View {
        ScrollView {
            ForEach(0..<5) { index in
                Image(images[index])
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 250, height: 445)
                    .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                    .id(index)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $scrolledID)
        .frame(width: 250, height: 445)
        .padding(.bottom, 50)
        .onChange(of: scrolledID) { oldValue, newValue in
            if let soundURL = Bundle.main.url(forResource: "SymbolLockSwipedSFX", withExtension: "wav") {
                AudioPlayer.playSound(url: soundURL, withID: "SymbolLockSwipedSFX")
            }
        }
    }
}

#Preview {
    CombinationLockView()
}
