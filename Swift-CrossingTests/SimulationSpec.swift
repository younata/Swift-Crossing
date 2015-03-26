import Quick
import Nimble
import Ra

class SimulationSpec: QuickSpec {
    override func spec() {
        var subject : Simulation! = nil
        var injector : Ra.Injector! = nil

        var fakeTimer : FakeTimer! = nil

        var landscape : LandScape! = nil

        beforeEach {
            let specAppMod = SpecApplicationModule()
            injector = Ra.Injector()
            specAppMod.inject(injector)

            fakeTimer = FakeTimer()

            injector.bind(kTimer, to: fakeTimer)

            subject = injector.create(kSimulation) as! Simulation

            landscape = LandScape()

            let calendar = NSCalendar.currentCalendar()
            let date = calendar.dateWithEra(1, year: 2015, month: 3, day: 24, hour: 6, minute: 0, second: 0, nanosecond: 0)!
            let components = NSDateComponents()
            components.hour = 6
            expect(landscape.weedTiles.count).to(equal(3))
            subject.addAction(Action(fireDate: date, repeatComponents: components, action: {(_) in landscape.addWeeds()}))
            subject.start()
        }

        describe("Every morning, at 6 am") {
            beforeEach {
                let calendar = NSCalendar.currentCalendar()
                if let sixAM = calendar.dateWithEra(1, year: 2015, month: 3, day: 24, hour: 6, minute: 0, second: 0, nanosecond: 0) {
                    fakeTimer.runAction(sixAM)
                } else {
                    expect(false).to(beTruthy())
                }
            }

            it("three new weeds are added to the town") {
                expect(landscape.weedTiles.count).to(equal(6))
            }
        }
    }
}
