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
                        expect(color).to(equal(NSColor.greenColor()))
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
