//
//  CombinationLockView.swift
//  BitRayed
//
//  Created by Ali Haidar on 24/06/24.
//

import SwiftUI

struct CombinationLockView: View {
    
    let leftArray = ["1 Left", "2. Left", "3 Left", "4 Left", "5 Left"]
    let midArray = ["1 Mid", "2. Mid", "3 Mid", "4 Mid", "5 Mid"]
    let rightArray = ["1 Right", "2. Right", "3 Right", "4 Right", "5 Right"]
    
    @State private var leftIndex: Int? = 0
    @State private var midIndex: Int? = 0
    @State private var rightIndex: Int? = 0
    
    @Environment(\.dismiss) private var dismiss
//    @State var scrolledID: Int? = 0
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            Image("level3_bg")
                .interpolation(.none)
                .resizable()
            
            HStack (spacing: -15) {
                CodeScrollView(images: leftArray, scrolledID: $leftIndex)
                CodeScrollView(images: midArray, scrolledID: $midIndex)
                CodeScrollView(images: rightArray, scrolledID: $rightIndex)
            }
            
            Rectangle()
                .frame(width: 730, height: 65)
                .position(x: 600, y: 199)
            
            Rectangle()
                .frame(width: 730, height: 60)
                .position(x: 600, y: 590)
            
            VStack {
                Spacer()
                Button {
                    print("left \(leftIndex!), mid \(midIndex!), right \(rightIndex!)")
                    if(leftIndex == 3 && midIndex == 1 && rightIndex == 4 ){
                        
                        defaults.set(true, forKey: "Puzzle3_done")
                        print("Correct")
                    }else{
                        print("wrong")
                    }
                } label: {
                    Text("Unlock")
                        .font(.largeTitle)
                        .bold()
                }
            }.padding()
            
            Color.black.opacity(0.2)
                .frame(width: 730, height: 65)
            
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



struct CodeScrollView: View{
    let images: [String]
    @Binding var scrolledID: Int?
    var body: some View{
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
    }
}




#Preview {
    CombinationLockView()
}
