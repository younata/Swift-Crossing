import Quick
import Nimble
import SceneKit

class LandScapeSpec: QuickSpec {
    override func spec() {
        var subject : LandScape! = nil

        beforeEach {
            subject = LandScape() as LandScape
        }

        describe("Creating a new landscape") {
            it("should create a plane with a green color") { // For now.
                let n = subject.childNodeWithName("Floor", recursively: false)
                expect(n).toNot(beNil())
                if let floor = n {
                    expect(floor.geometry).to(beAnInstanceOf(SCNPlane.self))
                    if let geom = floor.geometry as? SCNPlane {
                        expect(geom.width).to(equal(100))
                        expect(geom.height).to(equal(100))
                        expect(geom.firstMaterial).toNot(beNil())
                        if let mat = geom.firstMaterial {
                            let color = mat.diffuse.contents as NSColor
                            expect(color).to(equal(NSColor.grassGreen()))
                        }
                    }
                }
            }

            it("have 3 brown walls (cliffs) on the back and sides that each extend up 10 units") {
                let childNodes = subject.childNodesPassingTest {(node, _) in node.name != "Floor" }
                expect(childNodes.count).to(equal(3))
                for (i,x) in enumerate(childNodes) {
                    expect(x.geometry).to(beAnInstanceOf(SCNPlane.self))
                    if let g = x.geometry as? SCNPlane {
                        expect(g.firstMaterial).toNot(beNil())
                        if let color = g.firstMaterial?.diffuse.contents as? NSColor {
                            expect(color).to(equal(NSColor.brownColor()))
                        }
                        expect(g.width).to(equal(15))
                        expect(g.height).to(equal(100))
                    } else {
                        expect(false).to(beTruthy())
                    }
                    let angle = CGFloat(M_PI_2)
                    if i == 0 {
                        expect(SCNVector3EqualToVector3(x.position, SCNVector3Make(-50, 7.5, 0))).to(beTruthy())
                        expect(SCNVector3EqualToVector3(x.eulerAngles, SCNVector3Make(-angle, 0, -angle))).to(beTruthy())
                    } else if i == 1 {
                        expect(SCNVector3EqualToVector3(x.position, SCNVector3Make(0, 7.5, -50))).to(beTruthy())
                        expect(SCNVector3EqualToVector3(x.eulerAngles, SCNVector3Make(0, 0, angle))).to(beTruthy())
                    } else if i == 2 {
                        expect(SCNVector3EqualToVector3(x.position, SCNVector3Make(50, 7.5, 0))).to(beTruthy())
                        expect(SCNVector3EqualToVector3(x.eulerAngles, SCNVector3Make(angle, 0, -angle))).to(beTruthy())
                    }
                }
            }

            it("should attach a static physics body") {
                expect(subject.physicsBody).toNot(beNil())
                if let body = subject.physicsBody {
                    expect(body.type).to(equal(SCNPhysicsBodyType.Static))
                }
            }
        }
    }
}
