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