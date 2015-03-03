import SceneKit

class GameView: SCNView {

    var character : Character? = nil
    var cameraNode : SCNNode? = nil

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
        scene.rootNode.addChildNode(landScape.contents)

        let character = Character()
        scene.rootNode.addChildNode(character.contents)


        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        character.contents.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)

        let lookAtConstraint = SCNLookAtConstraint(target: character.contents)

        cameraNode.constraints = [lookAtConstraint]

        self.scene = scene
        self.character = character
        self.cameraNode = cameraNode

        showsStatistics = true
        backgroundColor = NSColor.blackColor()
    }
    
//    override func mouseDown(theEvent: NSEvent) {
//        /* Called when a mouse click occurs */
//        
//        // check what nodes are clicked
//        let p = self.convertPoint(theEvent.locationInWindow, fromView: nil)
//        if let hitResults = self.hitTest(p, options: nil) {
//            // check that we clicked on at least one object
//            if hitResults.count > 0 {
//                // retrieved the first clicked object
//                let result: AnyObject = hitResults[0]
//                
//                // get its material
//                let material = result.node!.geometry!.firstMaterial!
//                
//                // highlight it
//                SCNTransaction.begin()
//                SCNTransaction.setAnimationDuration(0.5)
//                
//                // on completion - unhighlight
//                SCNTransaction.setCompletionBlock() {
//                    SCNTransaction.begin()
//                    SCNTransaction.setAnimationDuration(0.5)
//                    
//                    material.emission.contents = NSColor.blackColor()
//                    
//                    SCNTransaction.commit()
//                }
//                
//                material.emission.contents = NSColor.redColor()
//                
//                SCNTransaction.commit()
//            }
//        }
//        
//        super.mouseDown(theEvent)
//    }

    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        character?.keyDown(theEvent.keyCode)
    }

    override func keyUp(theEvent: NSEvent) {
        super.keyUp(theEvent)
        character?.keyUp(theEvent.keyCode)
    }

}
