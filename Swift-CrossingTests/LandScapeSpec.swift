import Quick
import Nimble
import SceneKit

class LandScapeSpec: QuickSpec {
    override func spec() {
        var subject : LandScape! = nil

        beforeEach {
            subject = LandScape()
        }

        describe("Creating a new landscape") {
            it("should create a floor with a green color") { // For now.
                let node = subject.contents
                expect(node.geometry).to(beAnInstanceOf(SCNFloor.self))
                if let geom = node.geometry {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let color = mat.diffuse.contents as NSColor
                        expect(color).to(equal(NSColor.grassGreen()))
                    }
                }
            }

            it("have 3 brown walls (cliffs) on the back and sides that each extend up 10 units") {
                expect(subject.contents.childNodes.count).to(equal(3))
                let childNodes = subject.contents.childNodes
                for (i,x) in enumerate(childNodes) {
                    expect(x.geometry).to(beAnInstanceOf(SCNPlane.self))
                    if let g = x.geometry as? SCNPlane {
                        expect(g.firstMaterial).toNot(beNil())
                        if let color = g.firstMaterial?.diffuse.contents as? NSColor {
                            expect(color).to(equal(NSColor.brownColor()))
                        }
                        expect(g.width).to(equal(15))
                        expect(g.height).to(equal(100))
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
                expect(subject.contents.physicsBody).toNot(beNil())
                if let body = subject.contents.physicsBody {
                    expect(body.type).to(equal(SCNPhysicsBodyType.Static))
                }
            }
        }
    }
}
