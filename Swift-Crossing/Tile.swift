//
//  Tile.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/9/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Tile : SCNNode {
    var location : Vector2 = Vector2() {
        didSet {
            self.position = SCNVector3Make(location.x + 0.5, self.position.y, location.z + 0.5)
        }
    }

    var subnode : SCNNode = SCNNode()

    var canWalkOn: Bool = true

    override init() {
        super.init()
        let geom = SCNPlane(width: 1, height: 1)
        geom.firstMaterial?.diffuse.contents = NSColor.grassGreen()

        subnode = SCNNode(geometry: geom)
        subnode.eulerAngles = SCNVector3Make(CGFloat(-M_PI_2), 0, 0)
        subnode.physicsBody = SCNPhysicsBody.staticBody()
        addChildNode(subnode)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}