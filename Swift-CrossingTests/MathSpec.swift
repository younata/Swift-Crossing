import Quick
import Nimble

class MathSpec: QuickSpec {
    override func spec() {
        describe("clamp") {
            it("should return the number to clamp given if it's within the bounds") {
                expect(clamp(0, -1, 1) == 0).to(beTruthy())
            }

            it("should return the upper bound if the number to clamp is above the upper bound") {
                expect(clamp(2, -1, 1) == 1).to(beTruthy())
            }

            it("should return the lower bound if the number to clamp is below the lower bound") {
                expect(clamp(-2, -1, 1) == -1).to(beTruthy())
            }
        }

        describe("Fractal Brownian Motion") {
            var subject: FractalBrownianMotion! = nil
            beforeEach {
                subject = FractalBrownianMotion()
            }

            it("should return 0 by default for everything") {
                expect(subject.at(10, 5)).to(equal(0))
            }

            describe("Setting a noise function") {
                beforeEach {
                    subject.noise = {(x, y) in x*y }
                }

                it("should return numbers based on the noise function") {
                    expect(subject.at(5, 10)).to(equal(0.0175))
                }
            }
        }
    }
}
