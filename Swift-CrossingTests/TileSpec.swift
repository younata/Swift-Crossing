import Quick
import Nimble
import SceneKit

class TileSpec: QuickSpec {
    override func spec() {
        var subject : Tile! = nil

        beforeEach {
            subject = Tile()
        }

        describe("location") {
            it("should set position when it's set") {
                subject.location = Vector2(x: 2, z: 2)
                expect(subject.position).to(equal(SCNVector3Make(2.5, 0, 2.5)))
            }

            it("shouldn't reset the y position when it's set") {
                subject.position = SCNVector3Make(0, 3, 0)
                subject.location = Vector2(x: 2, z: 2)
                expect(subject.position).to(equal(SCNVector3Make(2.5, 3, 2.5)))
            }
        }
    }
}
