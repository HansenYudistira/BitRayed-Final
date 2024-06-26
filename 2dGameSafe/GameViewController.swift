import UIKit
import SpriteKit
import GameplayKit

public class GameViewController: UIViewController, SKPhysicsContactDelegate {
    
    private var scene: SKScene!
    private var sceneView = SKView()
    private var screenSize: CGSize!
    private var cameraNode: SKCameraNode!
    
    var selectedNode: SKSpriteNode!
    var humanNodeTappable = false
    var humanNodeTappable2 = false
    var humanNodeTappable3 = false
    var humanNodeTappable4 = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenSize()
        setup()
        addTapGestureRecognizer()
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
        
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 0.0, y: 0.0)
        scene.camera = cameraNode
        scene.addChild(cameraNode)
        
        let ghostNode = SKSpriteNode(imageNamed: "human")
        ghostNode.size = CGSize(width: 48, height: 48)
        ghostNode.position = CGPoint(x: 0.0, y: 0.0)
        ghostNode.physicsBody = SKPhysicsBody(rectangleOf: ghostNode.size)
        ghostNode.physicsBody?.affectedByGravity = false
        ghostNode.physicsBody?.isDynamic = true
        ghostNode.physicsBody?.categoryBitMask = bitMasks.ghost.rawValue
        ghostNode.physicsBody?.collisionBitMask = bitMasks.human.rawValue
        ghostNode.physicsBody?.contactTestBitMask = bitMasks.human.rawValue
        ghostNode.name = "ghost"
        scene.addChild(ghostNode)
       
        sceneView.presentScene(scene)
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let scene = scene else { return }
        let location = gesture.location(in: sceneView)
        
        let cameraPosition = scene.camera?.position ?? CGPoint.zero
        let adjustedLocation = CGPoint(x: location.x + cameraPosition.x - screenSize.width / 2, y: screenSize.height - location.y + cameraPosition.y - screenSize.height / 2)
        
        
        if humanNodeTappable, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human" {
            presentSafeViewController()
            return
        }
        
        if humanNodeTappable2, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human2" {
            presentVentViewController()
            return
        }
        
        if humanNodeTappable3, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human3" {
            presentShadowViewController()
            return
        }
        
        if humanNodeTappable4, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human4" {
            presentDrawerViewController()
            return
        }
        
        if let ghostNode = scene.childNode(withName: "ghost") as? SKSpriteNode,
           let cameraNode = scene.camera {
            let newPosition = CGPoint(x: adjustedLocation.x , y: adjustedLocation.y )

            let moveTo = SKAction.move(to: newPosition, duration: 1.0)
            ghostNode.run(moveTo)
            cameraNode.run(moveTo)
        }
    }
    
    private func presentShadowViewController() {
        let shadowViewController = ShadowViewController()
        shadowViewController.modalPresentationStyle = .fullScreen
        present(shadowViewController, animated: true, completion: nil)
    }
    
    private func presentDrawerViewController() {
        let drawerViewController = DrawerViewController()
        drawerViewController.modalPresentationStyle = .fullScreen
        present(drawerViewController, animated: true, completion: nil)
    }
    
    private func presentSafeViewController() {
        let safeViewController = SafeViewController()
        safeViewController.modalPresentationStyle = .fullScreen
        present(safeViewController, animated: true, completion: nil)
    }
    
    private func presentVentViewController() {
        let ventViewController = VentViewController()
        ventViewController.modalPresentationStyle = .fullScreen
        present(ventViewController, animated: true, completion: nil)
    }

    
}
