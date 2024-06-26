import UIKit
import SpriteKit

public class SafeViewController: UIViewController, SKPhysicsContactDelegate {
    
    private var scene: SKScene!
    private var sceneView = SKView()
    private var screenSize: CGSize!
    
    var selectedNode: SKSpriteNode!
    var initialRotation: CGFloat = 0.0
    
    private var isTapped = false
    
    let password = [1, 0, 2]
    var enteredPassword: [Int] = []
    var passwordCount = 0
    let defaults = UserDefaults.standard
    
    private var lastRotationDirection: RotationDirection = .none
    
    var rotateRight = true
    var rotateLeft = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenSize()
        setup()
        addControlButtons()
//        addRotateGestureRecognizer()
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
        let width = scene.size.width
        let height = scene.size.height
        
        let safeNode = SKSpriteNode(imageNamed: "safeDoor")
        safeNode.size = CGSize(width: width - 50, height: height - 200)
        safeNode.position = CGPoint(x: width / 2, y: height / 2 - 20)
        safeNode.zPosition = 0
        safeNode.physicsBody = SKPhysicsBody(rectangleOf: safeNode.size)
        safeNode.physicsBody?.affectedByGravity = false
        safeNode.physicsBody?.isDynamic = false
        safeNode.physicsBody?.categoryBitMask = bitMasks.safe.rawValue
        safeNode.name = "safe"
        safeNode.texture?.filteringMode = .nearest
        scene.addChild(safeNode)
        
        let lockNode = SKSpriteNode(imageNamed: "safeDial")
        lockNode.size = CGSize(width: 300, height: 300)
        lockNode.position = CGPoint(x: width / 2 + 200, y: height / 2)
        lockNode.zPosition = 1
        lockNode.physicsBody = SKPhysicsBody(circleOfRadius: lockNode.xScale)
        lockNode.physicsBody?.affectedByGravity = false
        lockNode.physicsBody?.isDynamic = false
        lockNode.physicsBody?.categoryBitMask = bitMasks.safe.rawValue
        lockNode.name = "lock"
        lockNode.texture?.filteringMode = .nearest
        scene.addChild(lockNode)
        
        let indicatorNode = SKSpriteNode(imageNamed: "safeIndicator")
        indicatorNode.size = CGSize(width: 50, height: 50)
        indicatorNode.position = CGPoint(x: 200, y: 210)
        indicatorNode.zPosition = 0
        indicatorNode.name = "indicator"
        indicatorNode.texture?.filteringMode = .nearest
        safeNode.addChild(indicatorNode)
        
        let handleNode = SKSpriteNode(imageNamed: "safeHandle")
        handleNode.size = CGSize(width: 300, height: 120)
        handleNode.position = CGPoint(x: -250, y: 0)
        handleNode.zPosition = 0
        handleNode.name = "handle"
        handleNode.texture?.filteringMode = .nearest
        safeNode.addChild(handleNode)
        
        let documentNode = SKSpriteNode(imageNamed: "proofCheating")
        documentNode.size = CGSize(width: 350, height: 350)
        documentNode.position = CGPoint(x: width / 2, y: height / 2)
        documentNode.zPosition = -1
        documentNode.name = "proofCheating"
        documentNode.texture?.filteringMode = .nearest
        scene.addChild(documentNode)
        
        let insideSafeNode = SKSpriteNode(imageNamed: "safeInside")
        insideSafeNode.size = CGSize(width: width, height: height)
        insideSafeNode.position = CGPoint(x: width / 2, y: height / 2)
        insideSafeNode.zPosition = -2
        insideSafeNode.texture?.filteringMode = .nearest
        scene.addChild(insideSafeNode)

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
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    private func makeSafeOpen() {
        guard let safeNode = scene.childNode(withName: "safe"), let lockNode = scene.childNode(withName: "lock") else { return }
        let moveAction = SKAction.moveBy(x: scene.size.width - 100, y: 0, duration: 2.0)
        safeNode.run(moveAction)
        lockNode.run(moveAction)
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let scene = scene else { return }
        let location = gesture.location(in: sceneView)
        let sceneLocation = scene.convertPoint(fromView: location)
        
        if let node = scene.atPoint(sceneLocation) as? SKSpriteNode, node.name == "proofCheating" {
            if isTapped == false {
                animateDocument(node)
                isTapped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.returnToGameViewController()
                }
            }
        }
    }

    private func animateDocument(_ documentNode: SKSpriteNode) {
        let scaleAction = SKAction.scale(by: 2, duration: 1)
        let reverseAction = scaleAction.reversed()
        let sequence = SKAction.sequence([scaleAction, reverseAction])
        documentNode.run(sequence)
    }
    
//    private func addRotateGestureRecognizer() {
//        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotateGesture(_:)))
//        sceneView.addGestureRecognizer(rotateGestureRecognizer)
//    }
//    
//    @objc private func handleRotateGesture(_ gesture: UIRotationGestureRecognizer) {
//        guard let scene = scene, let lockNode = scene.childNode(withName: "lock") as? SKSpriteNode else { return }
//        
//        let rotation = gesture.rotation
//        
//        switch gesture.state {
//            case .began:
//                initialRotation = lockNode.zRotation
//            case .changed:
//                let currentRotationDirection: RotationDirection = rotation > 0 ? .clockwise : .counterclockwise
//                if lastRotationDirection == .none || lastRotationDirection != currentRotationDirection {
//                    lockNode.zRotation = initialRotation - rotation
//                }
//            case .ended, .cancelled:
//                snapToNearestNumber(lockNode: lockNode, rotation: rotation)
//            default:
//                break
//        }
//    }
//    
//    private func snapToNearestNumber(lockNode: SKSpriteNode, rotation: CGFloat) {
//        let segmentAngle = .pi / 5.0
//        let normalizedRotation = lockNode.zRotation.truncatingRemainder(dividingBy: 2 * CGFloat.pi)
//        var angleIndex = Int((normalizedRotation + CGFloat.pi) / segmentAngle)
//        
//        angleIndex = (angleIndex + 10) % 10
//        
//        let snappedRotation = CGFloat(angleIndex) * segmentAngle - CGFloat.pi
//        
//        let rotateAction = SKAction.rotate(toAngle: snappedRotation, duration: 0.2, shortestUnitArc: true)
//        lockNode.run(rotateAction)
        
//        print("Current number: \(angleIndex)")
//        verifyPassword(at: angleIndex)
        
//        lastRotationDirection = rotation > 0 ? .clockwise : .counterclockwise
//    }
//    
//    private func verifyPassword(at index: Int) {
//        guard enteredPassword.count < password.count else { return }
//        if !enteredPassword.isEmpty && index == enteredPassword.last! {
//            print("Ignoring repeated entry: \(index)")
//            return
//        }
//        if index == password[enteredPassword.count] {
//            enteredPassword.append(index)
//            print("password skrg \(enteredPassword)")
//            if enteredPassword.count == password.count {
//                makeSafeOpen()
//                defaults.set(false, forKey: "Puzzle4_done")
//            }
//        } else {
//            print("password salah blog")
//            enteredPassword.removeAll()
//        }
//    }
    
    private func verifyPassword() {
        let currentNumber = (passwordCount + 100) % 10
        print("currentNumber = \(currentNumber)")

        enteredPassword.append(currentNumber)
        
        if enteredPassword.count == password.count {
            if enteredPassword == password {
                print("Password correct!")
                makeSafeOpen()
                defaults.set(true, forKey: "Puzzle4_done")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                    guard let self = self else { return }
                    if let scene = self.scene {
                        if let node = scene.childNode(withName: "proofCheating") as? SKSpriteNode {
                            self.animateDocument(node)
                        }
                    }
                    self.isTapped = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.returnToGameViewController()
                    }
                }
                
            } else {
                print("Password incorrect!")
                enteredPassword.removeAll()
            }
        }
    }
    
    private func addControlButtons() {
        let buttonSize = CGSize(width: 150, height: 150)
        let yPosition = sceneView.frame.height - 200
        
        let rotateLeftButton = UIButton(type: .custom)
        rotateLeftButton.setImage(UIImage(named: "left"), for: .normal)
        rotateLeftButton.frame = CGRect(x: 20, y: yPosition, width: buttonSize.width, height: buttonSize.height)
        rotateLeftButton.contentHorizontalAlignment = .fill
        rotateLeftButton.contentVerticalAlignment = .fill
        rotateLeftButton.addTarget(self, action: #selector(rotateLockLeft), for: .touchUpInside)
        view.addSubview(rotateLeftButton)
        
        let rotateRightButton = UIButton(type: .custom)
        rotateRightButton.setImage(UIImage(named: "right"), for: .normal)
        rotateRightButton.frame = CGRect(x: scene.size.width - 170, y: yPosition, width: buttonSize.width, height: buttonSize.height)
        rotateRightButton.contentHorizontalAlignment = .fill
        rotateRightButton.contentVerticalAlignment = .fill
        rotateRightButton.addTarget(self, action: #selector(rotateLockRight), for: .touchUpInside)
        view.addSubview(rotateRightButton)
        
        let submitButton = UIButton(type: .custom)
        submitButton.setImage(UIImage(named: "button_template"), for: .normal)
        submitButton.frame = CGRect(x: scene.size.width / 2 - 75, y: yPosition, width: buttonSize.width, height: buttonSize.height)
        submitButton.contentHorizontalAlignment = .fill
        submitButton.contentVerticalAlignment = .fill
        submitButton.addTarget(self, action: #selector(submitCurrentNumber), for: .touchUpInside)
        view.addSubview(submitButton)
        
        let submitLabel = UILabel(frame: submitButton.bounds)
        submitLabel.text = "Submit"
        submitLabel.textAlignment = .center
        submitLabel.textColor = .black
        if let customFont = UIFont(name: "dogica", size: 20) {
            submitLabel.font = customFont
        } else {
            submitLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }

        submitLabel.isUserInteractionEnabled = false
        submitButton.addSubview(submitLabel)
    }
    
    @objc private func rotateLockLeft() {
        if rotateLeft {
            rotateLockNode(by: -.pi / 5.0)
            passwordCount -= 1
            rotateRight = false
        }
    }
    
    @objc private func rotateLockRight() {
        if rotateRight {
            rotateLockNode(by: .pi / 5.0)
            passwordCount += 1
            rotateLeft = false
        }
    }
    
//    private func rotateLockNode(by angle: CGFloat) {
//        guard let lockNode = scene.childNode(withName: "lock") as? SKSpriteNode else { return }
//        let rotateAction = SKAction.rotate(byAngle: angle, duration: 0.2)
//        lockNode.run(rotateAction) {
//            self.snapToNearestNumber(lockNode: lockNode, rotation: angle)
//        }
//    }
    
    private func rotateLockNode(by angle: CGFloat) {
        guard let lockNode = scene.childNode(withName: "lock") as? SKSpriteNode else { return }
        let rotateAction = SKAction.rotate(byAngle: angle, duration: 0.5)
        lockNode.run(rotateAction)
    }
    
    @objc private func submitCurrentNumber() {
//        guard let lockNode = scene.childNode(withName: "lock") as? SKSpriteNode else { return }
//        let segmentAngle = .pi / 5.0
//        let normalizedRotation = lockNode.zRotation.truncatingRemainder(dividingBy: 2 * CGFloat.pi)
//        let angleIndex = Int((normalizedRotation + CGFloat.pi) / segmentAngle)
//        let correctedIndex = (angleIndex + 10) % 10
        verifyPassword()
        rotateLeft = !rotateLeft
        rotateRight = !rotateRight
    }
}
