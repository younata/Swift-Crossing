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

    public func normalize() -> SCNVector3 {
        let mag = sqrt(x*x + y*y + z*z)
        return SCNVector3Make(x/mag, y/mag, z/mag)
    }
}

public func ==(a: SCNVector3, b: SCNVector3) -> Bool {
    if fabs(a.x - b.x) > 1e-6 {
        return false
    }
    if fabs(a.y - b.y) > 1e-6 {
        return false
    }
    return fabs(a.z - b.z) < 1e-6
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