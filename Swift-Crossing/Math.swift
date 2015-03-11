//
//  Math.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/7/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

func clamp<T: Comparable>(n: T, lowerBound: T, upperBound: T) -> T {
    return min(upperBound, max(lowerBound, n))
}

class FractalBrownianMotion {
    var lacunarity : CGFloat = 2.0
    var octaves : Int = 3
    var gain : CGFloat = 0.5

    var length : CGFloat = 100.0

    var noise : (CGFloat, CGFloat) -> CGFloat = {(_, _) in 0}

    func at(x: CGFloat, _ y: CGFloat) -> CGFloat {
        var total : CGFloat = 0.0
        var frequency : CGFloat = 1.0 / length
        var amplitude = gain
        for i in 0..<octaves {
            let n = noise(x * frequency, y * frequency)
            total += n * amplitude
            frequency *= lacunarity
            amplitude *= gain
        }
        return total
    }
}

func linearInterpolation(a: CGFloat, b: CGFloat, weight: CGFloat) -> CGFloat {
    return ((1.0 - weight) * a) + (weight * b)
}

func dotproductGradient(ix: Int, iy: Int, x: CGFloat, y: CGFloat, gradient: [[[CGFloat]]]) -> CGFloat {
    let dx = x - CGFloat(ix)
    let dy = y - CGFloat(iy)

    return (dx*gradient[iy][ix][0] + dy*gradient[iy][ix][1])
}

func perlin(x: CGFloat, y: CGFloat, gradient: [[[CGFloat]]]) -> CGFloat {
    let x0 = x > 0.0 ? Int(x) : Int(x - 1)
    let x1 = x0 + 1
    let y0 = y > 0.0 ? Int(y) : Int(y - 1)
    let y1 = y0 + 1

    let weightX = x - CGFloat(x0)
    let weightY = y - CGFloat(y0)

    var n0 = dotproductGradient(x0, y0, x, y, gradient)
    var n1 = dotproductGradient(x1, y0, x, y, gradient)

    let ix0 = linearInterpolation(n0, n1, weightX)

    n0 = dotproductGradient(x0, y1, x, y, gradient)
    n1 = dotproductGradient(x1, y1, x, y, gradient)

    let ix1 = linearInterpolation(n0, n1, weightX)

    return linearInterpolation(ix0, ix1, weightY)
}
