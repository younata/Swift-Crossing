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

    func moveCharacter(x: CGFloat, _ z: CGFloat, running: Bool = false) {
        if let body = self.contents.physicsBody {
            let vel = body.velocity
            let magnitude = hypot(vel.x + x, vel.z + z)
            let nx = ((vel.x + x) / magnitude) * (running ? 2 : 1)
            let nz = ((vel.z + z) / magnitude) * (running ? 2 : 1)
            self.contents.physicsBody?.velocity = SCNVector3Make(nx, 0, nz)
        }
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