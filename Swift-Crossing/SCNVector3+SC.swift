//
//  SCNVector3+SC.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/7/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

extension SCNVector3 : Equatable, Printable {
    public var description : String {
        return "(\(x), \(y), \(z))"
    }
}

public func ==(a: SCNVector3, b: SCNVector3) -> Bool {
    return SCNVector3EqualToVector3(a, b)
}

public func ==(a: SCNVector3, b: CGFloat) -> Bool {
    return a.x == b && a.y == b && a.z == b
}

public func !=(a: SCNVector3, b: CGFloat) -> Bool {
    return !(a == b)
}

func +(a: SCNVector3, b: SCNVector3) -> SCNVector3 {
    return SCNVector3(x: a.x + b.x, y: a.y + b.y, z: a.z + b.z)
}

func +=(inout a: SCNVector3, b: SCNVector3) {
    a = a + b
}

func *(a: SCNVector3, b: CGFloat) -> SCNVector3 {
    let x = a.x * b
    let y = a.y * b
    let z = a.z * b
    return SCNVector3(x: x, y: y, z: z)
}