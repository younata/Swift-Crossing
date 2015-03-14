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

        describe("subnode") {
            var subnode: SCNNode! = nil
            beforeEach {
                subnode = subject.subnode
            }

            it("is rotated -pi in the x euler angle") {
                expect(subnode.eulerAngles).to(equal(SCNVector3Make(CGFloat(-M_PI_2), 0, 0)))
                return;
            }

            it("has a plane as the geometry") {
                expect(subnode.geometry).to(beAnInstanceOf(SCNPlane.self))
                if let geom = subnode.geometry as? SCNPlane {
                    expect(geom.width).to(equal(1))
                    expect(geom.height).to(equal(1))
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        if let color = mat.diffuse.contents as? NSColor {
                            expect(color).to(equal(NSColor.grassGreen()))
                        }
                    }
                }
            }

            it("has a static physicsbody") {

            }
        }
    }
}
