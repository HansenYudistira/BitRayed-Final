//
//  GameState.swift
//  2dGameSafe
//
//  Created by Ali Haidar on 24/06/24.
//

import Foundation

class GameState: ObservableObject{
    @Published var isGhostMode = true

    @Published var trashTapable = false
    @Published var bedTapable = false
    @Published var drawerTapable = false
    @Published var tvTapable = false
    @Published var chestTapable = false
    @Published var wardrobeTapable = false
    @Published var cabinetTapable = false
    @Published var safeTapable = false
    @Published var picFrameTapable = false
}
