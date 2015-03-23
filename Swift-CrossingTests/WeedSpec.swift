import Quick
import Nimble
import SceneKit

class WeedSpec: QuickSpec {
    override func spec() {
        var subject : Weed! = nil

        beforeEach {
            subject = Weed()
        }

        it("should have a light-green SCNShape") {
            expect(subject.geometry).to(beAnInstanceOf(SCNShape.self))
            if let geom = subject.geometry as? SCNShape {
                expect(geom.firstMaterial).toNot(beNil())
                if let mat = geom.firstMaterial, color = mat.diffuse.contents as? NSColor {
                    expect(color).to(equal(NSColor.greenColor()))
                }
            }
        }

        it("should have no physics") {
            expect(subject.physicsBody).to(beNil())
        }
    }
}
