//
//  Timer.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/23/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

class Timer {
    var timer : NSTimer! = nil

    var action : ((NSDate) -> (Void))? = nil

    init() {}

    func configure(interval: NSTimeInterval, action: (NSDate) -> (Void)) {
        self.action = action

        self.timer = NSTimer(fireDate: NSDate(), interval: interval, target: self, selector: "timerFired:", userInfo: nil, repeats: true)

    }

    func timerFired(timer: NSTimer) {
        if let action = self.action {
            action(NSDate())
        }
    }
}