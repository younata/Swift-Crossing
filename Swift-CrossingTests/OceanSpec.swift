import Quick
import Nimble
import SceneKit

class OceanSpec: QuickSpec {
    override func spec() {
        var subject: Ocean! = nil

        beforeEach {
            subject = Ocean()
        }

        it("should be a blue tile for now") {
            if let color = subject.subnode.geometry?.firstMaterial?.diffuse.contents as? NSColor {
                expect(color).to(equal(NSColor.blueColor()))
            } else {
                expect(false).to(beTruthy())
            }
        }
    }
}
