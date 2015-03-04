//
//  Tree.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/3/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Tree {
    lazy var contents : SCNNode = {
        return self.setupTree()
    }()

    private func setupTree() -> SCNNode {
        let base = SCNCylinder(radius: 0.5, height: 1.5)
        let brown = SCNMaterial()
        brown.diffuse.contents = NSColor.brownColor()
        base.firstMaterial = brown

        let leaves = SCNSphere(radius: 1)
        let green = SCNMaterial()
        green.diffuse.contents = NSColor.treeGreen()
        green.transparent.contents = NSColor(calibratedWhite: 0.9, alpha: 1.0)
        leaves.firstMaterial = green

        let root = SCNNode(geometry: base)
        let child = SCNNode(geometry: leaves)
        root.addChildNode(child)
        child.position = SCNVector3Make(0, 1.5, 0)

        return root
    }
}
