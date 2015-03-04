//
//  LandScape.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class LandScape {
    lazy var contents : SCNNode = {
        return self.generateLandScape()
    }()

    init() {
    }

    private func generateLandScape() -> SCNNode {
        let floor = SCNFloor()
        floor.reflectivity = 0

        let mat = SCNMaterial()
        mat.diffuse.contents = NSColor.grassGreen()
        floor.firstMaterial = mat
        let node = SCNNode(geometry: floor)
        node.physicsBody = SCNPhysicsBody.staticBody()

        for i in 0..<3 {
            let wall = SCNPlane(width: 15, height: 100)
            let wallMaterial = SCNMaterial()
            wallMaterial.diffuse.contents = NSColor.brownColor()
            wall.firstMaterial = wallMaterial
            let n = SCNNode(geometry: wall)

            let angle = CGFloat(M_PI_2)

            if i == 0 { // left
                n.position = SCNVector3Make(-50, 7.5, 0)
                n.eulerAngles = SCNVector3Make(-angle, 0, -angle)
            } else if i == 1 { // back
                n.position = SCNVector3Make(0, 7.5, -50)
                n.eulerAngles = SCNVector3Make(0, 0, angle)
            } else if i == 2 { // right
                n.position = SCNVector3Make(50, 7.5, 0)
                n.eulerAngles = SCNVector3Make(angle, 0, -angle)
            }
            node.addChildNode(n)
        }

        return node
    }
}
