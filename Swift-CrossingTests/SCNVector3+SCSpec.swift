import Quick
import Nimble
import SceneKit

class SCNVector3_SCSpec: QuickSpec {
    override func spec() {
        let a = SCNVector3Make(1, -1, 2)
        let b = SCNVector3Make(-2, 3, 5)

        it("should be printable") {
            expect("\(a)").to(equal("(1.0, -1.0, 2.0)"))
            expect(b.description).to(equal("(-2.0, 3.0, 5.0)"))
        }

        it("should == with two SCNVector3s") {
            expect(a == b).to(beFalsy())
            expect(a == SCNVector3Make(1, -1, 2)).to(beTruthy())
        }

        it("should == with an SCNVector3 and a scalar") {
            let n = SCNVector3Make(2, 2, 2)
            expect(a == 0).to(beFalsy())
            expect(n == 2).to(beTruthy())

            expect(a != 0).to(beTruthy())
        }

        describe("Adding") {

            it("should add two SCNVector3s") {
                let eq = SCNVector3Make(-1, 2, 7)
                expect(SCNVector3EqualToVector3(a + b, eq)).to(beTruthy())
            }

            it("should allow assignment") {
                var c = a
                let eq = SCNVector3Make(-1, 2, 7)
                c += b
                expect(SCNVector3EqualToVector3(c, eq)).to(beTruthy())
            }
        }

        it("should multiply an SCNVector3 with a scalar") {
            let b : CGFloat = 10

            let eq = SCNVector3Make(10, -10, 20)
            let res = SCNVector3EqualToVector3(a * b, eq)
            expect(res).to(beTruthy())
        }
    }
}
