//
//  ContactManager.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 24/06/24.
//

import SpriteKit

class ContactManager: ObservableObject {
    weak var scene: GameScene?
    var gameState = GameState()
    
    var actionSign: SKSpriteNode?

    init(scene: GameScene) {
        self.scene = scene
        self.gameState = scene.gameState ?? GameState()
        self.actionSign = scene.hero.childNode(withName: "actionSign") as? SKSpriteNode
    }
    
    func handleContactBegin(contactA: String?, contactB: String?) {
        
        if (contactA == "character" && contactB == "trash_bin") || (contactA == "trash_bin" && contactB == "character") {
            gameState.trashTapable = true
            actionSign?.isHidden = false
        }
        
        if (contactA == "character" && contactB == "drawer") || (contactA == "drawer" && contactB == "character") {
            gameState.drawerTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 2")
        }
        
        if (contactA == "character" && contactB == "tv") || (contactA == "tv" && contactB == "character") {
            gameState.tvTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 3")
        }
        
        if (contactA == "character" && contactB == "chest") || (contactA == "chest" && contactB == "character") {
            gameState.chestTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 4")
        }
        if (contactA == "character" && contactB == "wardrobe") || (contactA == "wardrobe" && contactB == "character") {
            gameState.wardrobeTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 5")
        }
        if (contactA == "character" && contactB == "file_cabinet") || (contactA == "file_cabinet" && contactB == "character") {
            gameState.cabinetTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 6")
        }
        if (contactA == "character" && contactB == "safe") || (contactA == "safe" && contactB == "character") {
            gameState.safeTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 7")
        }
        if (contactA == "character" && contactB == "pic_frame") || (contactA == "pic_frame" && contactB == "character") {
            gameState.picFrameTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 8")
        }
    }
    
    func handleContactEnd(contactA: String?, contactB: String?) {
        if (contactA == "character" && contactB == "drawer") || (contactA == "drawer" && contactB == "character") {
            gameState.drawerTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "trash_bin") || (contactA == "trash_bin" && contactB == "character") {
            gameState.trashTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "tv") || (contactA == "tv" && contactB == "character") {
            gameState.tvTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "chest") || (contactA == "chest" && contactB == "character") {
            gameState.chestTapable = false
            actionSign?.isHidden = true
        }
        if (contactA == "character" && contactB == "wardrobe") || (contactA == "wardrobe" && contactB == "character") {
            gameState.wardrobeTapable = false
            actionSign?.isHidden = true
        }
        if (contactA == "character" && contactB == "file_cabinet") || (contactA == "file_cabinet" && contactB == "character") {
            gameState.cabinetTapable = false
            actionSign?.isHidden = true
        }
        if (contactA == "character" && contactB == "safe") || (contactA == "safe" && contactB == "character") {
            gameState.safeTapable = false
            actionSign?.isHidden = true
        }
        if (contactA == "character" && contactB == "pic_frame") || (contactA == "pic_frame" && contactB == "character") {
            gameState.picFrameTapable = false
            actionSign?.isHidden = true
        }
    }
}



