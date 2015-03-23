import Quick
import Nimble
import SceneKit

class BeachSpec: QuickSpec {
    override func spec() {
        var subject: Beach! = nil

        beforeEach {
            subject = Beach()
        }

        it("should be a sand color") {
            if let color = subject.subnode.geometry?.firstMaterial?.diffuse.contents as? NSColor {
                expect(color).to(equal(NSColor.sandColor()))
            } else {
                expect(false).to(beTruthy())
            }
        }
    }
}
