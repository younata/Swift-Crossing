//
//  Character.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Character : SCNNode {
    override init() {
        super.init()
        generateCharacter()
    }

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    private var movementVector: (x: CGFloat, z: CGFloat, running: Bool) = (0,0,false)

    var velocity : Vector2 = Vector2() {
        didSet {
            movementVector = (x: velocity.x, z: velocity.z, running: movementVector.running)
        }
    }

    func moveCharacter(x: CGFloat, _ z: CGFloat) {
        if let body = physicsBody {
            movementVector.x += x
            movementVector.z += z

            movementVector.x = clamp(movementVector.x, -1, 1)
            movementVector.z = clamp(movementVector.z, -1, 1)
        }
    }

    func setRunning(running: Bool) {
        movementVector.running = running
    }

    func updateCharacter(delta: NSTimeInterval) {
        println("\(delta)")
        var magnitude = hypot(movementVector.x, movementVector.z)
        magnitude = magnitude == 0 ? 1 : magnitude

        let nx = (movementVector.x / magnitude) * (movementVector.running ? 2 : 1)
        let nz = (movementVector.z / magnitude) * (movementVector.running ? 2 : 1)

        let x = nx / CGFloat(delta)
        let z = nz / CGFloat(delta)

        self.position += SCNVector3Make(x, 0, z)
    }

    // MARK - Private Methods

    private func generateCharacter() {
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

        geometry = box
        physicsBody = SCNPhysicsBody.dynamicBody()
    }
}