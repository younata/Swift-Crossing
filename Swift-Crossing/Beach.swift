//
//  Beach.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/22/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Cocoa

class Beach: Tile {
    override init() {
        super.init()
        if let geom = subnode.geometry {
            if let mat = geom.firstMaterial {
                mat.diffuse.contents = NSColor.sandColor()
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
