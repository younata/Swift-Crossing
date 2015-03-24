//
//  FakeTimer.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/23/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

class FakeTimer : Timer {
    override func timerFired(timer: NSTimer) {}

    func runAction(date: NSDate) {
        if let action = self.action {
            action(date)
        }
    }
}
