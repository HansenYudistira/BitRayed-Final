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
    
    var body: some View{
        VStack {
            HStack{
                Spacer()
                if puzzle1Done{
                    Button {
                        print("key")
                    } label: {
                        Image("KeyFall")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Circle())
                    }
                }else{
                    
                }
                
                if puzzle2Done{
                    Button {
                        print("Folder 1. surat cinta & hint about hiding something in painting")
                    } label: {
                        Image("Folder 1")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Circle())
                    }
                }
                
                if puzzle3Done{
                    Button {
                        print("Surat Ancaman & kode brankas")
                    } label: {
                        Image("document")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Circle())
                    }
                }
                
                if puzzle4Done{
                    Button {
                        print("foto suami dengan selingkuhan")
                    } label: {
                        Image("Painting")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Circle())
                    }
                }
                
                if puzzle5Done{
                    Button {
                        print("screwdriver acquired")
                    } label: {
                        Image("drawerScrewdriver")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Circle())
                    }
                }
                
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    InventoryItem()
}
