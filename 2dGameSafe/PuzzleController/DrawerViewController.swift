import UIKit
import SpriteKit

public class DrawerViewController: UIViewController, SKPhysicsContactDelegate {
    
    private var scene: SKScene!
    private var sceneView = SKView()
    private var screenSize: CGSize!
    
    private var selectedNode: SKSpriteNode!
    
    private var isTapped = false
    let defaults = UserDefaults.standard
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenSize()
        setup()
        addTapGestureRecognizer()
        addPanGestureRecognizer()
    }
    
    private func setupScreenSize() {
        let screenBounds = UIScreen.main.bounds
        let screenWidth = max(screenBounds.width, screenBounds.height)
        let screenHeight = min(screenBounds.width, screenBounds.height)
        screenSize = CGSize(width: screenWidth, height: screenHeight)
        sceneView.frame = CGRect(origin: .zero, size: screenSize)
        view.addSubview(sceneView)
    }
    
    func setup() {
        scene = SKScene(size: screenSize)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        
        scene.physicsWorld.contactDelegate = self
        let width = scene.size.width
        let height = scene.size.height
        
        let centerWidth = width / 2
        let centerHeight = height / 2
        
        let drawerBackground = SKSpriteNode(imageNamed: "drawerBackground")
        drawerBackground.size = CGSize(width: width, height: height)
        drawerBackground.position = CGPoint(x: centerWidth, y: centerHeight)
        drawerBackground.zPosition = -5
        drawerBackground.texture?.filteringMode = .nearest
        scene.addChild(drawerBackground)
        
        let drawerNode = SKSpriteNode(imageNamed: "drawerBase")
        drawerNode.size = CGSize(width: width - 200, height: height - 400)
        drawerNode.position = CGPoint(x: centerWidth, y: centerHeight)
        drawerNode.zPosition = -1
        drawerNode.texture?.filteringMode = .nearest
        drawerNode.name = "drawer"
        
        let sideDrawerNode = SKSpriteNode(imageNamed: "drawerKanan")
        sideDrawerNode.size = CGSize(width: 200, height: drawerNode.size.height)
        sideDrawerNode.position = CGPoint(x: drawerNode.size.width / 2, y: 0)
        sideDrawerNode.zPosition = 0
        sideDrawerNode.physicsBody = SKPhysicsBody(texture: sideDrawerNode.texture!, size: sideDrawerNode.size)
        sideDrawerNode.physicsBody?.affectedByGravity = false
        sideDrawerNode.physicsBody?.isDynamic = false
        sideDrawerNode.texture?.filteringMode = .nearest
        drawerNode.addChild(sideDrawerNode)
        
        let sideDrawerNode2 = SKSpriteNode(imageNamed: "drawerKiri")
        sideDrawerNode2.size = CGSize(width: 200, height: drawerNode.size.height)
        sideDrawerNode2.position = CGPoint(x: -drawerNode.size.width / 2, y: 0)
        sideDrawerNode2.zPosition = 0
        sideDrawerNode2.physicsBody = SKPhysicsBody(texture: sideDrawerNode2.texture!, size: sideDrawerNode2.size)
        sideDrawerNode2.physicsBody?.affectedByGravity = false
        sideDrawerNode2.physicsBody?.isDynamic = false
        sideDrawerNode2.texture?.filteringMode = .nearest
        drawerNode.addChild(sideDrawerNode2)
        
        let topDrawerNode = SKSpriteNode(imageNamed: "drawerTop")
        topDrawerNode.size = CGSize(width: drawerNode.size.width + 50, height: 450)
        topDrawerNode.position = CGPoint(x: 0, y: drawerNode.position.y / 2 + 200)
        topDrawerNode.zPosition = 0
        topDrawerNode.physicsBody = SKPhysicsBody(texture: topDrawerNode.texture!, size: topDrawerNode.size)
        topDrawerNode.physicsBody?.affectedByGravity = false
        topDrawerNode.physicsBody?.isDynamic = false
        topDrawerNode.texture?.filteringMode = .nearest
        drawerNode.addChild(topDrawerNode)
        
        let frontDrawerNode = SKSpriteNode(imageNamed: "drawerFront")
        frontDrawerNode.size = CGSize(width: drawerNode.size.width + 400, height: 100)
        frontDrawerNode.position = CGPoint(x: 0, y: -drawerNode.position.y / 2)
        frontDrawerNode.zPosition = 0
        frontDrawerNode.physicsBody = SKPhysicsBody(texture: frontDrawerNode.texture!, size: frontDrawerNode.size)
        frontDrawerNode.physicsBody?.affectedByGravity = false
        frontDrawerNode.physicsBody?.isDynamic = false
        frontDrawerNode.texture?.filteringMode = .nearest
        drawerNode.addChild(frontDrawerNode)
        
        scene.addChild(drawerNode)
        
        let centerX = screenSize.width / 2
        let centerY = screenSize.height / 2
        let rangeX: CGFloat = 250
        let rangeY: CGFloat = 50
        let rangeZ: [CGFloat] = [2, 3, 4, 5, 6]
        
        addItem(named: "drawerScrewdriver", size: CGSize(width: 44, height: 256), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: [], baseName: "screw", itemCount: 1, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerMarker", size: CGSize(width: 48, height: 184), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "marker", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerPen", size: CGSize(width: 32, height: 248), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "pen", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerScissor", size: CGSize(width: 136, height: 272), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "scissor", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerStapler", size: CGSize(width: 76, height: 188), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "stappler", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerPaperclip", size: CGSize(width: 20, height: 60), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "papperclip", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerBattery", size: CGSize(width: 28, height: 80), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "battery", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        addItem(named: "drawerEraser", size: CGSize(width: 56, height: 92), centerPosition: CGPoint(x: centerX, y: centerY), zPositions: rangeZ, baseName: "eraser", itemCount: 5, rangeX: rangeX, rangeY: rangeY)
        
        let screwNode = scene.childNode(withName: "screw1") as! SKSpriteNode
        screwNode.zRotation = .pi / 5
        sceneView.presentScene(scene)
        addCloseButton()
    }
    
    private func addCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .red
        closeButton.layer.cornerRadius = 10
        closeButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        closeButton.addTarget(self, action: #selector(returnToGameViewController), for: .touchUpInside)
        
        view.addSubview(closeButton)
    }
    
    @objc private func returnToGameViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func randomizePosition(centerX: CGFloat, centerY: CGFloat, rangeX: CGFloat, rangeY: CGFloat) -> CGPoint {
        let randomX = CGFloat.random(in: (centerX - rangeX)...(centerX + rangeX))
        let randomY = CGFloat.random(in: (centerY - rangeY)...(centerY + rangeY))
        return CGPoint(x: randomX, y: randomY)
    }
    
    func addItem(named imageName: String, size: CGSize, centerPosition: CGPoint, zPositions: [CGFloat], baseName: String, itemCount: Int, rangeX: CGFloat, rangeY: CGFloat) {
        for i in 1...itemCount {
            let node = SKSpriteNode(imageNamed: imageName)
            node.size = size
            let randomPosition = randomizePosition(centerX: centerPosition.x, centerY: centerPosition.y, rangeX: rangeX, rangeY: rangeY)
            node.position = randomPosition
            if let randomZPosition = zPositions.randomElement() {
                node.zPosition = randomZPosition
            } else {
                node.zPosition = 1
            }
            node.name = "\(baseName)\(i)"
            node.texture?.filteringMode = .nearest
            scene.addChild(node)
        }
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    private func makeDrawerAffectedByGravity() {
        guard let drawerNode = scene.childNode(withName: "drawer") else { return }
        drawerNode.physicsBody?.affectedByGravity = true
        drawerNode.physicsBody?.isDynamic = true
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sceneView.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let scene = scene else { return }
        let location = gesture.location(in: sceneView)
        let sceneLocation = scene.convertPoint(fromView: location)
        
        if let node = scene.atPoint(sceneLocation) as? SKSpriteNode, node.name == "screw1" {
            if isTapped == false {
                animateScrew(node)
                defaults.set(false, forKey: "Puzzle5_done")
                isTapped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.returnToGameViewController()
                }
                print("screw tapped")
            }
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let scene = scene, let drawerNode = scene.childNode(withName: "drawer") as? SKSpriteNode else { return }
        let location = gesture.location(in: sceneView)
        let sceneLocation = scene.convertPoint(fromView: location)
        
        let xMin = drawerNode.position.x - drawerNode.size.width / 2 + 200
        let xMax = drawerNode.position.x + drawerNode.size.width / 2 - 200
        let yMin = drawerNode.position.y - drawerNode.size.height / 2 + 200
        let yMax = drawerNode.position.y + drawerNode.size.height / 2 - 300
        
        switch gesture.state {
        case .began:
            if let node = scene.atPoint(sceneLocation) as? SKSpriteNode,
               node.name != "drawer", node.name != "screw1" {
                selectedNode = node
            }
        case .changed:
            if let selectedNode = selectedNode {
                var newPosition = sceneLocation
                newPosition.x = max(xMin, min(newPosition.x, xMax))
                newPosition.y = max(yMin, min(newPosition.y, yMax))
                selectedNode.position = newPosition
            }
        case .ended, .cancelled:
            selectedNode = nil
        default:
            break
        }
    }
    
    private func animateScrew(_ knifeNode: SKSpriteNode) {
        let scaleAction = SKAction.scale(by: 2, duration: 1)
        let reverseAction = scaleAction.reversed()
        let sequence = SKAction.sequence([scaleAction, reverseAction])
        knifeNode.zPosition = 10
        knifeNode.run(sequence)
    }
}
