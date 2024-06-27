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
    @AppStorage("trashFound") var trashFound: Bool = false
    
    @State private var showHint = false
    @State private var hintMessage = ""
    
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
                }
                
                if puzzle2Done {
                    Button {
                        showHintWithMessage("Folder 1: Surat Ancaman & hint about hiding something in painting")
                    } label: {
                        InvImg(imageName: "Folder 1")
                    }
                }
                
                if puzzle3Done {
                    Button {
                        showHintWithMessage("Surat cinta")
                    } label: {
                        InvImg(imageName: "document")
                    }
                }
                
                if puzzle4Done {
                    Button {
                        showHintWithMessage("Picture")
                    } label: {
                        InvImg(imageName: "Painting")
                    }
                }
                
                if puzzle5Done {
                    Button {
                        showHintWithMessage("Maybe I could open something with this")
                    } label: {
                        InvImg(imageName: "drawerScrewdriver")
                    }
                }
                
                if trashFound {
                    Button {
                        showHintWithMessage("> < >> \nIs that some type of code?")
                    } label: {
                        InvImg(imageName: "evidence_trash")
                    }
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
