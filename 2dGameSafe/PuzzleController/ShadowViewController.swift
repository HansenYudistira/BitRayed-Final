import UIKit
import SceneKit

public class ShadowViewController: UIViewController, SCNPhysicsContactDelegate {
    
    private var scene: SCNScene!
    private var sceneView = SCNView()
    
    private var screenSize = CGSize.zero
    private var point: CGPoint = .zero
    private var prepoint: CGPoint = .zero
    
    private var plane:SCNNode = SCNNode()
    
    private var previousCameraPosition: SCNVector3?
    private var previousCameraOrientation: SCNQuaternion?
    private var displayLink: CADisplayLink?
    
    private var myLight: SCNNode!
    
    private var initialPlaneOrientation: SCNQuaternion?
    
    public override func viewDidLoad() {
        super.viewDidLoad ()
        setupScreenSize()
        setup()
        addPanGesture()
    }
    
    private func setupScreenSize() {
        let screenBounds = UIScreen.main.bounds
        let screenWidth = max(screenBounds.width, screenBounds.height)
        let screenHeight = min(screenBounds.width, screenBounds.height)
        screenSize = CGSize(width: screenWidth, height: screenHeight)
    }
    
    func setup () {
        sceneView.frame = CGRect (origin: .zero, size: screenSize)
        scene = SCNScene(named: "Box.scn")
        
        scene?.background.contents = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        let scene2 = SCNScene(named: "PolyPlane.scn")
        plane = (scene2?.rootNode.childNode(withName: "Plane", recursively: true))!
        plane.scale = SCNVector3(x: 0.4, y: 0.4, z: 0.4)
        plane.eulerAngles = SCNVector3(x: 0, y: .pi , z: 0)
        plane.position = SCNVector3(x: 0, y: 2, z: 0)
        plane.name = "hero"
        scene?.rootNode.addChildNode(plane)
        let Ball = SCNSphere(radius: 0.8)
        plane.physicsBody = SCNPhysicsBody(type: .static, shape: .init(geometry: Ball))
        plane.physicsBody?.categoryBitMask = 1
        plane.physicsBody?.collisionBitMask = 2
        plane.physicsBody?.contactTestBitMask = 1
        let propeller = scene?.rootNode.childNode(withName: "Propeller", recursively: true)
        propeller?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0, z: 30, duration: 1)))
        
        let boxScene = SCNScene(named: "Box.scn")
        if let box = boxScene?.rootNode.childNode(withName: "box", recursively: true) {
            box.castsShadow = true
            if let material = box.geometry?.firstMaterial {
                material.lightingModel = .lambert
                material.isDoubleSided = true
                material.transparency = 1.0
                material.writesToDepthBuffer = true
            }
            scene?.rootNode.addChildNode(box)
        } else {
            print("Box not found in Box.scn")
        }
        
        if let spotlight = scene?.rootNode.childNode(withName: "spotlight", recursively: true) {
            myLight?.removeFromParentNode()
            
            spotlight.light?.castsShadow = true
            spotlight.light?.shadowMode = .deferred
            spotlight.light?.shadowColor = UIColor.black.withAlphaComponent(0.5)
            spotlight.light?.shadowRadius = 10
            spotlight.light?.shadowMapSize = CGSize(width: 2048, height: 2048)
            spotlight.light?.shadowSampleCount = 16
            
            scene?.rootNode.addChildNode(spotlight)
        } else {
            print("Spotlight not found in Box.scn")
        }
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.camera?.orthographicScale = 8
        cameraNode.position = SCNVector3(x: -6, y: 4, z: -5)
        cameraNode.look(at: SCNVector3(x: -1, y: 3, z: -8))
        
        sceneView.scene = scene
        sceneView.pointOfView = cameraNode
        sceneView.autoenablesDefaultLighting = true
        scene?.physicsWorld.contactDelegate = self
        
        previousCameraPosition = cameraNode.position
        previousCameraOrientation = cameraNode.orientation
        
//        spriteScene = OverlayScene(size: screenSize)
//        sceneView.overlaySKScene = spriteScene
        
//        sceneView.showsStatistics = true
//        sceneView.allowsCameraControl = true
//        sceneView.debugOptions = [.showWireframe, .showBoundingBoxes, .showPhysicsShapes]
        view.addSubview(sceneView)
        
        initialPlaneOrientation = plane.orientation
        
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
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: sceneView)
        let rotationScale: Float = 0.005
        
        switch gesture.state {
        case .began:
            initialPlaneOrientation = plane.orientation
        case .changed:
            guard let initialOrientation = initialPlaneOrientation else { return }
            
            let angleX = Float(translation.x) * rotationScale
            let angleY = Float(translation.y) * rotationScale
            
            let rotationX = SCNQuaternion(angle: angleX, axis: SCNVector3(0, 1, 0))
            let rotationY = SCNQuaternion(angle: angleY, axis: SCNVector3(1, 0, 0))
            
            let combinedRotation = rotationX * rotationY
            
            plane.orientation = initialOrientation * combinedRotation
            
        case .ended:
            initialPlaneOrientation = nil
        default:
            break
        }
    }
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
    }
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didUpdate: SCNPhysicsContact) {
        //print("didUpdate!")
        
    }
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didEnd: SCNPhysicsContact) {
        //print("didEnd!")
    }
}

extension SCNQuaternion {
    static func * (lhs: SCNQuaternion, rhs: SCNQuaternion) -> SCNQuaternion {
        return SCNQuaternion(
            x: lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z - lhs.w * rhs.w,
            y: lhs.x * rhs.y + lhs.y * rhs.x + lhs.z * rhs.w - lhs.w * rhs.z,
            z: lhs.x * rhs.z - lhs.y * rhs.w + lhs.z * rhs.x + lhs.w * rhs.y,
            w: lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y + lhs.w * rhs.x
        )
    }
}

extension SCNQuaternion {
    init(angle: Float, axis: SCNVector3) {
        let halfAngle = angle / 2.0
        let sinHalfAngle = sin(halfAngle)
        self.init(x: axis.x * sinHalfAngle, y: axis.y * sinHalfAngle, z: axis.z * sinHalfAngle, w: cos(halfAngle))
    }
}
