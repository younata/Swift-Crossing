//
//  Vector2.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/9/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

struct Vector2 : Printable, Equatable {
    let x: CGFloat
    let z: CGFloat

    init() {
        self.init(x: 0, z: 0)
    }

    init(x: CGFloat, z: CGFloat) {
        self.x = x
        self.z = z
    }

    var description : String {
        return "(\(x), \(z))"
    }
}

func == (a: Vector2, b: Vector2) -> Bool {
    return (fabs(a.x - b.x) < 1e-6) && (fabs(a.z - b.z) < 1e-6)
}

func + (a: Vector2, b: Vector2) -> Vector2 {
    return Vector2(x: a.x + b.x, z: a.z + b.z)
}

func - (a: Vector2, b: Vector2) -> Vector2 {
    return Vector2(x: a.x - b.x, z: a.z - b.z)
}

func * (a: Vector2, b: Vector2) -> Vector2 {
    return Vector2(x: a.x * b.x, z: a.z * b.z)
}

func / (a: Vector2, b: Vector2) -> Vector2 {
    return Vector2(x: a.x / b.x, z: a.z / b.z)
}