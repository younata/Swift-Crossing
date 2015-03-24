//
//  Simulation.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/23/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit
import Ra

class Simulation {
    var timer : Timer? = nil

    var injector : Ra.Injector? = nil

    private var actions : [Action] = []

    init() {}

    func start() {
        timer = injector?.create(kTimer) as? Timer
        timer?.configure(1.0 / 60.0, action: onTimerFire)
    }

    func addAction(action: Action) {
        actions.append(action)
    }

    private func onTimerFire(date: NSDate) {
        actions = actions.filter({
            if $0.runActionIfPossible(date) {
                return $0.fireDate.compare(date) == .OrderedDescending
            }
            return false
        })
    }
}