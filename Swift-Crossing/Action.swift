//
//  Action.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/24/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

class Action : Comparable { // Lawsuit
    private(set) var fireDate: NSDate
    let action : (NSTimeInterval) -> (Void)
    let repeatComponents : NSDateComponents?

    private var lastFireDate: NSDate? = nil

    init(fireDate: NSDate, repeatComponents: NSDateComponents?, action: (NSTimeInterval) -> (Void)) {
        self.fireDate = fireDate
        self.repeatComponents = repeatComponents
        self.action = action
    }

    func runActionIfPossible(date: NSDate) -> Bool {
        let res = fireDate.compare(date)
        if fireDate.compare(date) != .OrderedDescending {
            let delta : NSTimeInterval
            if let lastFireDate = self.lastFireDate {
                delta = date.timeIntervalSinceDate(lastFireDate)
            } else {
                delta = 0
            }

            action(delta)
            let calendar = NSCalendar.currentCalendar()
            if let repeatComponents = self.repeatComponents, nextFireDate = calendar.nextDateAfterDate(fireDate, matchingComponents: repeatComponents, options: .MatchNextTimePreservingSmallerUnits) {
                fireDate = nextFireDate
                lastFireDate = date
            }
            return true
        }
        return false
    }
}

func ==(a: Action, b: Action) -> Bool {
    return a.fireDate.compare(b.fireDate) == .OrderedSame
}

func <(a: Action, b: Action) -> Bool {
    return a.fireDate.compare(b.fireDate) == .OrderedAscending
}