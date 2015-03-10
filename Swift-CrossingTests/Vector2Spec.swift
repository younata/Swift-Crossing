import Quick
import Nimble

class Vector2Spec: QuickSpec {
    override func spec() {
        var subject: Vector2! = nil
        beforeEach {
            subject = Vector2(x: 3.25, z: 2.5)
        }

        it("should init with zeros") {
            subject = Vector2()
            expect(subject.x).to(equal(0))
            expect(subject.z).to(equal(0))
        }

        it("should allow init with any arbitrary ") {
            expect(subject.x).to(equal(3.25))
            expect(subject.z).to(equal(2.5))
        }

        it("should be printable") {
            expect(subject.description).to(equal("(3.25, 2.5)"))
            expect("\(subject)").to(equal("(3.25, 2.5)"))
        }

        it("should be equatable") {
            var other = Vector2(x: 3.25, z: 2.5)
            expect(subject).to(equal(other))
            expect(subject).toNot(equal(Vector2()))
            expect(subject).to(equal(Vector2(x: 3.2500001, z: 2.5)))
        }

        it("should be addable") {
            expect(subject + Vector2(x: 1, z: 1)).to(equal(Vector2(x: 4.25, z: 3.5)))
        }

        it("should be subtractable") {
            expect(subject - Vector2(x: 1, z: 1)).to(equal(Vector2(x: 2.25, z: 1.5)))
        }

        it("should be multipliable by another vector") {
            expect(subject * Vector2(x: 2, z: 2)).to(equal(Vector2(x: 6.5, z: 5)))
        }

        it("should be divisable by another vector") {
            expect(subject / Vector2(x: 2, z: 2)).to(equal(Vector2(x: 1.625, z: 1.25)))
        }
    }
}
