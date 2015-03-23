import SceneKit
import GameController

class GameView: SCNView, SCNSceneRendererDelegate {

    var character : Character? = nil
    var cameraNode : SCNNode? = nil
    var trees : [Tree] = []

    func setup() {
        let scene = SCNScene()

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = NSColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)

        let landScape = LandScape()
        scene.rootNode.addChildNode(landScape)

        let ocean = Ocean()
        scene.rootNode.addChildNode(ocean)
        ocean.position = SCNVector3Make(0, 0, 55)

        let character = Character()
        scene.rootNode.addChildNode(character)
        character.position = SCNVector3Make(0, 1, 0)

        let tree = Tree()
        landScape.addChildNode(tree)
        tree.position = SCNVector3Make(5, 0.75, 0)
        trees = [tree]

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        character.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)

        let lookAtConstraint = SCNLookAtConstraint(target: character)

        cameraNode.constraints = [lookAtConstraint]

        self.scene = scene
        self.character = character
        self.cameraNode = cameraNode

        showsStatistics = true
        allowsCameraControl = true
        jitteringEnabled = true
        backgroundColor = NSColor.blackColor()

        GCController.startWirelessControllerDiscoveryWithCompletionHandler {
            if let controller = GCController.controllers().first as? GCController {
                self.setupController(controller)
            }
        }
    }

    func setupController(controller: GCController) {
        controller.controllerPausedHandler = {(controller) in
        }

        if let gamepad = controller.gamepad {
            gamepad.valueChangedHandler = {(gamepad, element) in
                if let pad = element as? GCControllerDirectionPad {
                    let vel = Vector2(x: CGFloat(pad.xAxis.value()), z: CGFloat(pad.yAxis.value()))
                    self.character?.velocity = vel
                }
            }
        }
    }

    override func mouseUp(theEvent: NSEvent) {
        super.mouseUp(theEvent)

        for tree in trees {
            tree.shake()
        }
    }

    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        let keyCode = theEvent.keyCode

        switch (keyCode) {
        case 126: // Up arrow
            character?.moveCharacter(0, -1)
        case 125: // Down arrow
            character?.moveCharacter(0, 1)
        case 124: // Right arrow
            character?.moveCharacter(1, 0)
        case 123: // Left arrow
            character?.moveCharacter(-1, 0)
        default:
            break
        }
    }

    override func keyUp(theEvent: NSEvent) {
        super.keyUp(theEvent)
        let keyCode = theEvent.keyCode

        switch (keyCode) {
        case 126: // Up arrow
            character?.moveCharacter(0, 1)
        case 125: // Down arrow
            character?.moveCharacter(0, -1)
        case 124: // Right arrow
            character?.moveCharacter(-1, 0)
        case 123: // Left arrow
            character?.moveCharacter(1, 0)
        default:
            break
        }
    }
}
