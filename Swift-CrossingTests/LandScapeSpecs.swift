import Quick
import Nimble
import SceneKit

class LandScapeSpecs: QuickSpec {
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
                        let color = mat.ambient.contents as NSColor
                        expect(color).to(equal(NSColor.greenColor()))
                    }
                }
            }
        }
    }
}
