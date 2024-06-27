//
//  GameScene.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import Foundation
import SpriteKit
import AVFoundation
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    @AppStorage("Puzzle1_done") var puzzle1Done: Bool = false
    @AppStorage("Puzzle2_done") var puzzle2Done: Bool = false
    @AppStorage("Puzzle3_done") var puzzle3Done: Bool = false
    @AppStorage("Puzzle4_done") var puzzle4Done: Bool = false
    @AppStorage("Puzzle5_done") var puzzle5Done: Bool = false
    @AppStorage("Puzzle6_done") var puzzle6Done: Bool = false
    
    var hero = SKSpriteNode()
    var police = SKSpriteNode()
    var policeRightFrames: [SKTexture] = []
    var policeDownFrames: [SKTexture] = []
    var policeLeftFrames: [SKTexture] = []
    var policeUpFrames: [SKTexture] = []
    var protagonisRightFrames: [SKTexture] = []
    var protagonisDownFrames: [SKTexture] = []
    var protagonisLeftFrames: [SKTexture] = []
    var protagonisUpFrames: [SKTexture] = []
    
    var currentAnimationDirection: AnimationDirection = .none
    
    var stuff = SKSpriteNode()
    var actionSign = SKSpriteNode()
    let hisTexture = SKTexture(imageNamed: "protagonis")
    var moveToLeft = false
    var moveToRight = false
    var moveUp = false
    var moveDown = false
    var actionButton = false
    var possesButton = false
    var isPossessed = false
    var possessionTimeRemaining: Int = 60
    var cameraNode = SKCameraNode()
    var warningSign: SKSpriteNode!
    var heroNode: SKSpriteNode!
    var possessionTimer: Timer?
    var possessionTimerLabel: SKLabelNode!
    
    var gameState: GameState?

    var contactManager: ContactManager!
    var viewControllerPresenter: ViewControllerPresenter!
    
    let collisionNames = ["bed", "drawer", "tv", "chest", "wardrobe", "file_cabinet", "safe", "pic_frame", "large_table", "left_chair_1", "left_chair_2", "right_chair_1", "right_chair_2", "stove", "kitchen_sink", "trash_bin", "sofa", "tv_table", "fridge", "flower", "door"]
    
    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.backgroundColor = .clear
        
        setupCamera()
        
        addHero()
        
        addPolice()
        
        addPoliceMovement()
        
        addCollisions(names: collisionNames)
        
        contactManager = ContactManager(scene: self)
        
        viewControllerPresenter = ViewControllerPresenter(presentingViewController: viewController()!)
        
//        addRainEffect()
        
        for node in self.children {
            if(node.name == "wallPhysics") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tilePhysics(map: someTileMap)
//                    someTileMap.removeFromParent()
                }
                break
            }
        }
    }
    
    func updateFlowerTexture(flowerNum: String) {
        if let flower = self.childNode(withName: "flower") as? SKSpriteNode {
            flower.texture = SKTexture(imageNamed: flowerNum)
            flower.texture?.filteringMode = .nearest
        }
    }
    
    func addRainEffect() {
        if let rainParticle = SKEmitterNode(fileNamed: "Rain") {
            rainParticle.particleTexture = SKTexture(imageNamed: "character")
            rainParticle.particleSize = CGSize(width: 10, height: 10)
            rainParticle.position = CGPoint(x: -300, y: 100)
            rainParticle.speed = 10.0
            rainParticle.particleLifetime = 2.0
            rainParticle.particleBirthRate = 100.0
            rainParticle.zPosition = -10
            rainParticle.targetNode = self
            rainParticle.particlePositionRange = CGVector(dx: self.size.width, dy: 0)
            self.addChild(rainParticle)
        } else {
            print("Rain particle not found")
        }
    }
    
    func setupCamera() {
        cameraNode = SKCameraNode()
        cameraNode.xScale = 0.2
        cameraNode.yScale = 0.2
        camera = cameraNode
        addChild(cameraNode)
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let position = touch.location(in: self)
//            let touchNode = self.nodes(at: position)
//            
//            for node in touchNode {
//                if node.name == "left" {
//                    moveToLeft = true
//                }
//                if node.name == "right" {
//                    moveToRight = true
//                }
//                if node.name == "up" {
//                    moveUp = true
//                }
//                if node.name == "down" {
//                    moveDown = true
//                }
//            }
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let position = touch.location(in: self)
//            let touchNode = self.nodes(at: position)
//            
//            for node in touchNode {
//                if node.name == "left" {
//                    moveToLeft = false
//                }
//                if node.name == "right" {
//                    moveToRight = false
//                }
//                if node.name == "up" {
//                    moveUp = false
//                }
//                if node.name == "down" {
//                    moveDown = false
//                }
//            }
//        }
//    }
//    
    override func update(_ currentTime: TimeInterval) {
        var movementDirection: AnimationDirection = .none
        
        if puzzle1Done{
            updateFlowerTexture(flowerNum: "Flower 3")
        }
        if puzzle2Done{
            updateFlowerTexture(flowerNum: "Flower 4")
        }
        if puzzle3Done{
            updateFlowerTexture(flowerNum: "Flower 5")
        }
        if puzzle4Done{
            updateFlowerTexture(flowerNum: "Flower 6")
        }
        if puzzle5Done{
            updateFlowerTexture(flowerNum: "Flower 7")
        }
        if puzzle6Done{
            updateFlowerTexture(flowerNum: "Flower 8")
        }
        
        if moveToLeft {
            hero.position.x -= 2
            movementDirection = .left
        }
        if moveToRight {
            hero.position.x += 2
            movementDirection = .right
        }
        if moveUp {
            hero.position.y += 2
            movementDirection = .up
        }
        if moveDown {
            hero.position.y -= 2
            movementDirection = .down
        }
        
        updateHeroAnimation(direction: movementDirection)
        
        if actionButton {
            if let gameState = gameState {
                
                if gameState.drawerTapable {
                    viewControllerPresenter.present(viewControllerType: .drawer)
                } else if gameState.chestTapable {
                    viewControllerPresenter.present(viewControllerType: .safe)
                } else if gameState.tvTapable {
                    if(defaults.bool(forKey: "Puzzle5_done")){
                        viewControllerPresenter.present(viewControllerType: .vent)
                    }else{
                        
                    }
                }
                
                else if gameState.wardrobeTapable {
                    viewControllerPresenter.presentSwiftUI(viewSwiftUIType: .wardrobe)
                } else if gameState.cabinetTapable {
                    if(defaults.bool(forKey: "Puzzle1_done")){
                        viewControllerPresenter.presentSwiftUI(viewSwiftUIType: .cabinet)
                        if let soundURL = Bundle.main.url(forResource: "FilingCabinetOpenSFX", withExtension: "wav") {
                            AudioPlayer.playSound(url: soundURL, withID: "FilingCabinetOpenSFX")
                        }
                    }else{
                        print("")
                    }
                } else if gameState.safeTapable {
                    if(defaults.bool(forKey: "Puzzle2_done")){
                        viewControllerPresenter.presentSwiftUI(viewSwiftUIType: .lockpick)
                    }else{
                        
                    }
                }
                
                else if gameState.picFrameTapable {
                    viewControllerPresenter.presentSwiftUI(viewSwiftUIType: .picture)
                }
            }
        }
        actionButton = false
        
        if hero.intersects(police) && possesButton {
            handleContactBetweenHeroAndPolice()
        }
        
        possesButton = false
        cameraNode.position = hero.position
    }
    
    func handleContactBetweenHeroAndPolice() {
        isPossessed = true
        if isPossessed {
            police.position = CGPoint(x: -1000.0, y: -1000.0)
            startPossessionTimer()
            if let soundURL = Bundle.main.url(forResource: "possessedSFX", withExtension: "mp3") {
                AudioPlayer.playSound(url: soundURL, withID: "possessedSFX")
            }
            police.removeAllActions()
        }
        
        if let hero = self.childNode(withName: "character") as? SKSpriteNode {
            hero.texture = SKTexture(imageNamed: "police")
            hero.alpha = 1.0
            hero.texture?.filteringMode = .nearest
        }
    }
    
    func startPossessionTimer() {
        possessionTimer?.invalidate()
        possessionTimeRemaining = 60
        possessionTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePossessionTimer), userInfo: nil, repeats: true)
        
        possessionTimerLabel.isHidden = false
        updatePossessionTimerLabel()
    }
    
    @objc func updatePossessionTimer() {
        possessionTimeRemaining -= 1
        updatePossessionTimerLabel()
        
        if possessionTimeRemaining <= 0 {
            possessionTimer?.invalidate()
            endPossession()
        }
    }
    
    @objc func endPossession() {
        isPossessed = false
        police.position = CGPoint(x: -400, y: -350)
        addPoliceMovement()
        possessionTimerLabel.isHidden = true
        if let hero = self.childNode(withName: "character") as? SKSpriteNode {
            hero.removeAction(forKey: "heroAnimation")
            hero.texture = SKTexture(imageNamed: "protagonis")
            hero.alpha = 0.5
            hero.size = CGSize(width: 32, height: 32)
            hero.texture?.filteringMode = .nearest
        }
    }
    
    func updatePossessionTimerLabel() {
        possessionTimerLabel.text = "Possession Time: \(possessionTimeRemaining)s"
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        contactManager.handleContactBegin(contactA: contact.bodyA.node?.name, contactB: contact.bodyB.node?.name)
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        contactManager.handleContactEnd(contactA: contact.bodyA.node?.name, contactB: contact.bodyB.node?.name)
    }
    
    private func showActionSign(){
        
    }
    
    func savePuzzleState(puzzleID: String, isSolved: Bool) {
        UserDefaults.standard.set(isSolved, forKey: puzzleID)
    }
    
    func loadPuzzleState(puzzleID: String) -> Bool {
        return UserDefaults.standard.bool(forKey: puzzleID)
    }
}
