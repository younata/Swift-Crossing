//
//  Weed.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/22/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

// Not marijuana.
class Weed: SCNNode {
    override init() {
        super.init()

        let path = NSBezierPath()
        path.moveToPoint(NSMakePoint(0.45, 0))
        path.lineToPoint(NSMakePoint(0.4, 0.25))
        path.lineToPoint(NSMakePoint(0.55, 0.5))
        path.lineToPoint(NSMakePoint(0.5, 0.25))
        path.lineToPoint(NSMakePoint(0.5, 0))
        path.closePath()

        let geom = SCNShape(path: path, extrusionDepth: 0.01)
        geom.firstMaterial?.diffuse.contents = NSColor.greenColor()

        geometry = geom

        physicsBody = nil
    }

    required init(coder: NSCoder) {
        fatalError("")
    }
}
