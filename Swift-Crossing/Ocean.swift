//
//  Ocean.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/7/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Ocean: SCNNode {
    override init() {
        super.init()
        let ocean = SCNPlane(width: 100, height: 10)
        ocean.firstMaterial?.diffuse.contents = NSColor.blueColor()

        let oceanNode = SCNNode(geometry: ocean)
        oceanNode.name = "Ocean"
        oceanNode.eulerAngles = SCNVector3Make(CGFloat(-M_PI_2), 0, 0)
        addChildNode(oceanNode)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
