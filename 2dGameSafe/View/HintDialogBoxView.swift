//
//  HintDialogBoxView.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 26/06/24.
//

import SwiftUI

struct HintDialogBoxView: View {
    
    let hintText: String
    @State private var isShowing = true
    
    var body: some View {
        if isShowing {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    
                    Text(hintText)
                        .font(.custom("Dogica", size: 21))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .lineSpacing(10)
                        .frame(width: SizeConstant.fullWidth * 0.67, height: 150, alignment: .center)
                    
                    Spacer().frame(height: 10)
                }
                .frame(width: SizeConstant.boxWidth * 0.75, height: 220)
                .border(.darkerGray, width: 10)
                .border(.gray, width: 5)
                .background(.darkerWhite)
            }
            .frame(width: SizeConstant.boxWidth, height: 220)
            .padding(.top, SizeConstant.fullHeight * 0.61)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isShowing = false
                }
            }
        }
    }
}

#Preview {
    HintDialogBoxView(hintText: "Do Something !!!")
}
