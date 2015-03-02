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

    func keyDown(keyCode: UInt16) {
/*
        case 126:       // up arrow
        case 125:       // down arrow
        case 124:       // right arrow
        case 123:       // left arrow
*/
        switch (keyCode) {
        case 126: // Up arrow
            moveCharacter(-1, 0)
        case 125: // Down arrow
            moveCharacter(1, 0)
        case 124: // Right arrow
            moveCharacter(0, 1)
        case 123: // Left arrow
            moveCharacter(0, -1)
        default:
            break
        }
    }

    func keyUp(keyCode: UInt16) {
        switch (keyCode) {
        case 126: // Up arrow
            moveCharacter(1, 0)
        case 125: // Down arrow
            moveCharacter(-1, 0)
        case 124: // Right arrow
            moveCharacter(0, -1)
        case 123: // Left arrow
            moveCharacter(0, 1)
        default:
            break
        }
    }

    func moveCharacter(z: CGFloat, _ x: CGFloat) {
        if let body = self.contents.physicsBody {
            let vel = body.velocity
            let nx = max(min(vel.x + x, 1), -1)
            let nz = max(min(vel.z + z, 1), -1)
            self.contents.physicsBody?.velocity = SCNVector3Make(nx, 0, nz)
        }
    }

    // MARK - Private Methods

    private func generateCharacter() -> SCNNode {
        let box = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0.05)

        let mat = SCNMaterial()
        mat.diffuse.contents = NSColor.whiteColor()
        box.firstMaterial = mat
        let node = SCNNode(geometry: box)
        node.physicsBody = SCNPhysicsBody.dynamicBody()
        return node
    }
}