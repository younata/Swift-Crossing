//
//  Tree.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/3/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Tree : SCNNode {
    override init() {
        super.init()
        setupTree()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTree() {
        let base = SCNCylinder(radius: 0.5, height: 1.5)
        let brown = SCNMaterial()
        brown.diffuse.contents = NSColor.brownColor()
        base.firstMaterial = brown

        let leaves = SCNSphere(radius: 1)
        let green = SCNMaterial()
        green.diffuse.contents = NSColor.treeGreen()
        green.transparent.contents = NSColor(calibratedWhite: 0.9, alpha: 1.0)
        leaves.firstMaterial = green

        geometry = base

        let child = SCNNode(geometry: leaves)
        addChildNode(child)
        child.position = SCNVector3Make(0, 1.5, 0)

        physicsBody = SCNPhysicsBody.staticBody()
    }
}
