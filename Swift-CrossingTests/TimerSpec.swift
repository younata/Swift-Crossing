import Quick
import Nimble

class TimerSpec: QuickSpec {
    override func spec() {
        var subject: Timer! = nil

        beforeEach {
            subject = Timer()
        }

        it("executes a block when the timer fires") {
            let expectation = self.expectationWithDescription("calls the block")
            subject.configure(1) {(_) in
                expectation.fulfill()
            }
            self.waitForExpectationsWithTimeout(10, handler: {(_) in })
        }
    }
}
