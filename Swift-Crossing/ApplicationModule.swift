//
//  ApplicationModule.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/23/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation
import Ra

let kSimulation = "simulation"
let kTimer = "timer"

class ApplicationModule {
    func inject(injector: Ra.Injector) {
        injector.bind(kSimulation, toClosure: {
            let sim = Simulation()
            sim.injector = injector
            return sim
        })

        injector.bind(kTimer, toClosure: {
            return Timer()
        })
    }
}