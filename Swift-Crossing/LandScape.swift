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
        mat.diffuse.contents = NSColor.greenColor()
        floor.firstMaterial = mat
        let node = SCNNode(geometry: floor)
        node.physicsBody = SCNPhysicsBody.staticBody()
        return node
    }
}
