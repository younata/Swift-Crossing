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
    let action : (Void) -> (Void)
    let repeatComponents : NSDateComponents?

    init(fireDate: NSDate, repeatComponents: NSDateComponents?, action: (Void) -> (Void)) {
        self.fireDate = fireDate
        self.repeatComponents = repeatComponents
        self.action = action
    }

    func runActionIfPossible(date: NSDate) -> Bool {
        let res = fireDate.compare(date)
        println("\(fireDate), \(date)")
        println("orderedAscending: \(res == .OrderedAscending), orderedSame: \(res == .OrderedSame), orderedDescending: \(res == .OrderedDescending)")
        if fireDate.compare(date) != .OrderedDescending {
            action()
            let calendar = NSCalendar.currentCalendar()
            if let repeatComponents = self.repeatComponents, date = calendar.nextDateAfterDate(fireDate, matchingComponents: repeatComponents, options: .MatchNextTimePreservingSmallerUnits) {
                fireDate = date
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