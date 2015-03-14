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

    var canWalkOn: Bool = true
}