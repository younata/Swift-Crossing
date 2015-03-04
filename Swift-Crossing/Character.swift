//
//  Character.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Character {
    lazy var contents : SCNNode = {
        return self.generateCharacter()
    }()

    init() {}

    private var movementVector: (x: CGFloat, z: CGFloat, running: Bool) = (0,0,false)

    func moveCharacter(x: CGFloat, _ z: CGFloat) {
        if let body = self.contents.physicsBody {
            movementVector.x += x
            movementVector.z += z

            let magnitude = hypot(movementVector.x, movementVector.z)

            let nx = (movementVector.x / magnitude) * (movementVector.running ? 2 : 1)
            let nz = (movementVector.z / magnitude) * (movementVector.running ? 2 : 1)

            self.contents.physicsBody?.velocity = SCNVector3Make(nx, 0, nz)
        }
    }

    func toggleRunning() {
        movementVector.running = !movementVector.running
    }

    // MARK - Private Methods

    private func generateCharacter() -> SCNNode {
//        let box = SCNBox(width: 0.45, height: 1.67, length: 0.24, chamferRadius: 0.0)
        let box = SCNBox(width: 0.5, height: 1, length: 0.5, chamferRadius: 0.0)


        let mat = SCNMaterial()
        mat.diffuse.contents = NSColor.brownColor()
        var materials = [mat]
        for i in 0..<5 {
            let mat = SCNMaterial()
            mat.diffuse.contents = NSColor.whiteColor()
            materials.append(mat)
        }
        box.materials = materials
        let node = SCNNode(geometry: box)
        node.physicsBody = SCNPhysicsBody.dynamicBody()
        return node
    }
}