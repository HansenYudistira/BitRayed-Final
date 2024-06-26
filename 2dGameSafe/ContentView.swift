//
//  ContentView.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 13/06/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack{
//            RainfallView()
//            MainGameView()
//            GameViewControllerRepresentable()
            StartView()
        }
        .ignoresSafeArea()
    }
}



#Preview {
    ContentView()
}
