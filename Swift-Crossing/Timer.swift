//
//  Timer.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/23/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

class Timer : NSObject {
    var timer : NSTimer! = nil

    private(set) var action : ((NSDate) -> (Void))? = nil

    func configure(interval: NSTimeInterval, action: (NSDate) -> (Void)) {
        self.action = action

        self.timer = NSTimer(fireDate: NSDate(), interval: interval, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSDefaultRunLoopMode)

    }

    func timerFired(timer: NSTimer) {
        if let action = self.action {
            action(NSDate())
        }
    }
}