import Quick
import Nimble

class ActionSpec: QuickSpec {
    override func spec() {
        var subject : Action! = nil
        var date : NSDate! = nil
        var components : NSDateComponents! = nil
        var calendar : NSCalendar! = nil

        beforeEach {
            calendar = NSCalendar.currentCalendar()
            date = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)

            components = NSDateComponents()
            components.day = 31

            subject = Action(fireDate: date, repeatComponents: components) {(_) in}
        }

        describe("Comparable") {
            it("is equal based on fireDate") {
                let same = Action(fireDate: date, repeatComponents: nil, action: {(_) in})
                expect(subject).to(equal(same))
            }

            it("reports actions that fire earlier than subject are less than (come before) subject") {
                let earlierDate = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 29, second: 0, nanosecond: 0)!
                let earlierThan = Action(fireDate: earlierDate, repeatComponents: nil, action: {(_) in})
                expect(subject).to(beGreaterThan(earlierThan))
            }

            it("reports actions that fire later than subject are greater than (come after) subject") {
                let laterDate = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 31, second: 0, nanosecond: 0)!
                let laterThan = Action(fireDate: laterDate, repeatComponents: nil, action: {(_) in})
                expect(subject).to(beLessThan(laterThan))
            }
        }

        describe("-runActionIfPossible:") {

            context("when an action is called the first time") {
                it("passes in 0 as the argument") {
                    subject = Action(fireDate: date, repeatComponents: components) {(delta) in
                        expect(delta).to(beCloseTo(0, within: 1e-6))
                    }
                    let fireDate = NSCalendar.currentCalendar().dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)!
                    expect(subject.runActionIfPossible(fireDate)).to(beTruthy())
                }
            }

            context("subsequently running actions") {
                var deltaTime : NSTimeInterval = -10

                let fireDate = NSCalendar.currentCalendar().dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)!

                beforeEach {
                    subject = Action(fireDate: date, repeatComponents: components) {(delta) in
                        println("\(delta)")
                        deltaTime = delta
                    }
                    deltaTime = -10
                    subject.runActionIfPossible(fireDate)
                }

                it("should input the time passed") {
                    let nextDate = calendar.dateWithEra(1, year: 2015, month: 4, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)!
                    subject.runActionIfPossible(nextDate)
                    expect(deltaTime).to(equal(2678400.0000))
                }
            }

            context("when the given date is after the fireDate") {
                beforeEach {
                    let expectation = self.expectationWithDescription("action")
                    subject = Action(fireDate: date, repeatComponents: components) {(_) in
                        expectation.fulfill()
                    }
                }

                it("should run the next action") {
                    if let nextDate = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 30, second: 1, nanosecond: 0) {
                        expect(subject.runActionIfPossible(nextDate)).to(beTruthy())
                    } else {
                        expect(false).to(beTruthy())
                    }
                    self.waitForExpectationsWithTimeout(1, handler: {(_) in })
                }

                it("the fireDate is updated") {
                    if let nextDate = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 30, second: 1, nanosecond: 0) {
                        subject.runActionIfPossible(nextDate)
                    }
                    let nextDate = calendar.dateWithEra(1, year: 2015, month: 4, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)
                    expect(subject.fireDate).to(equal(nextDate))
                }
            }

            context("when the given date is on the fireDate") {
                beforeEach {
                    let expectation = self.expectationWithDescription("action")
                    subject = Action(fireDate: date, repeatComponents: components) {(_) in
                        expectation.fulfill()
                    }
                }

                it("should run the next action") {
                    expect(subject.runActionIfPossible(date)).to(beTruthy())
                    self.waitForExpectationsWithTimeout(1, handler: {(_) in })
                }

                it("the fireDate is updated") {
                    subject.runActionIfPossible(date)
                    let nextDate = calendar.dateWithEra(1, year: 2015, month: 4, day: 31, hour: 1, minute: 30, second: 0, nanosecond: 0)
                    expect(subject.fireDate).to(equal(nextDate))
                }
            }

            context("when the given date is before the fireDate") {
                beforeEach {
                    subject = Action(fireDate: date, repeatComponents: components) {(_) in
                        expect(false).to(beTruthy())
                    }
                }

                it("should not run the next action") {
                    if let nextDate = calendar.dateWithEra(1, year: 2015, month: 3, day: 31, hour: 1, minute: 29, second: 59, nanosecond: 0) {
                        expect(subject.runActionIfPossible(nextDate)).to(beFalsy())
                    } else {
                        expect(false).to(beTruthy())
                    }
                }

                it("the fireDate should not be changed") {
                    expect(subject.fireDate).to(equal(date))
                }
            }
        }
    }
}
