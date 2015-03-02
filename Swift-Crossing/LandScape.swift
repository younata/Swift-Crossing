//
//  LandScape.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class LandScape {
    let contents : SCNNode

    init() {
        let floor = SCNFloor()
        floor.reflectivity = 0
        let mat = SCNMaterial()
        mat.ambient.contents = NSColor.greenColor()
        floor.firstMaterial = mat
        contents = SCNNode(geometry: floor)
    }
}
