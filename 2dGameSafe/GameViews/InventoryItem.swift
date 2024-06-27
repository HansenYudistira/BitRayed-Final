//
//  InventoryItem.swift
//  2dGameSafe
//
//  Created by Ali Haidar on 26/06/24.
//

import SwiftUI

struct InventoryItem: View {
    
    @AppStorage("Puzzle1_done") var puzzle1Done: Bool = false
    @AppStorage("Puzzle2_done") var puzzle2Done: Bool = false
    @AppStorage("Puzzle3_done") var puzzle3Done: Bool = false
    @AppStorage("Puzzle4_done") var puzzle4Done: Bool = false
    @AppStorage("Puzzle5_done") var puzzle5Done: Bool = false
    @AppStorage("Puzzle6_done") var puzzle6Done: Bool = false
    @AppStorage("trashFound") var trashFound: Bool = false
    
    @State private var showHint = false
    @State private var hintMessage = ""
    @State private var isHintShowing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                if puzzle1Done {
                    Button {
                        showHintWithMessage("I got a key \nWhat can i open with this?")
                    } label: {
                        InvImg(imageName: "Key Clean")
                    }
                    .disabled(isHintShowing)
                }
                
                if puzzle2Done {
                    Button {
                        showHintWithMessage("Folder 1: Threatening letter & there must be something on the painting")
                    } label: {
                        InvImg(imageName: "Folder 1")
                    }
                    .disabled(isHintShowing)
                }
                
                if puzzle3Done {
                    Button {
                        showHintWithMessage("Love Letter")
                    } label: {
                        InvImg(imageName: "document")
                    }
                    .disabled(isHintShowing)
                }
                
                if puzzle4Done {
                    Button {
                        showHintWithMessage("Picture")
                    } label: {
                        InvImg(imageName: "Painting")
                    }
                    .disabled(isHintShowing)
                }
                
                if puzzle5Done {
                    Button {
                        showHintWithMessage("Maybe I could open something with this")
                    } label: {
                        InvImg(imageName: "drawerScrewdriver")
                    }
                    .disabled(isHintShowing)
                }
                
                if puzzle6Done {
                    Button {
                        showHintWithMessage("There is knife covered with RED SCARF")
                    } label: {
                        InvImg(imageName: "Background")
                    }
                    .disabled(isHintShowing)
                }
                
                if trashFound {
                    Button {
                        showHintWithMessage("> < >> \nIs that some type of code?")
                    } label: {
                        InvImg(imageName: "evidence_trash")
                    }
                    .disabled(isHintShowing)
                }
            }
            Spacer()
            
            if showHint {
                HintDialogBoxView(hintText: hintMessage)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showHint = false
                                isHintShowing = false
                            }
                        }
                    }
            }
        }
        .padding()
    }
    
    private func showHintWithMessage(_ message: String) {
        hintMessage = message
        withAnimation {
            showHint = true
            isHintShowing = true
        }
    }
}

#Preview {
    InventoryItem()
}

struct InvImg: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 50, height: 50)
            .padding(25)
            .background(Image("inventoryBg").resizable())
    }
}
