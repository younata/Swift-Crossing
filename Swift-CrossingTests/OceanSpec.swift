import Quick
import Nimble
import SceneKit

class OceanSpec: QuickSpec {
    override func spec() {
        var subject: Ocean! = nil

        beforeEach {
            subject = Ocean()
        }

        it("should be a blue plane for now") {
            let n = subject.childNodeWithName("Ocean", recursively: false)
            expect(n).toNot(beNil())
            if let node = n {
                expect(node.eulerAngles).to(equal(SCNVector3Make(CGFloat(-M_PI_2), 0, 0)))
                expect(node.geometry).to(beAnInstanceOf(SCNPlane.self))
                if let geom = node.geometry as? SCNPlane {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let color = mat.diffuse.contents as! NSColor
                        expect(color).to(equal(NSColor.blueColor()))
                    }
                    expect(geom.height).to(equal(10))
                    expect(geom.width).to(equal(100))
                }
            }
        }

        it("should have an invisble wall on the north side preventing anything from going through it.") {
            // Yeah, I have no idea how to test this :/
        }
    }
}
