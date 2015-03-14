//
//  Ocean.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/7/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class Ocean: Tile {
    override init() {
        super.init()
        if let geom = subnode.geometry {
            if let mat = geom.firstMaterial {
                mat.diffuse.contents = NSColor.blueColor()
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
