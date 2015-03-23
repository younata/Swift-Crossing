import Quick
import Nimble
import SceneKit

class TreeSpec: QuickSpec {
    override func spec() {
        var subject: Tree! = nil

        beforeEach {
            subject = Tree()
        }

        it("should have a brown cylinder as the base") {
            expect(subject.geometry).to(beAnInstanceOf(SCNCylinder.self))
            if let geom = subject.geometry as? SCNCylinder {
                expect(geom.firstMaterial).toNot(beNil())
                if let mat = geom.firstMaterial, color = mat.diffuse.contents as? NSColor {
                    expect(color).to(equal(NSColor.brownColor()))
                }
                expect(geom.height).to(equal(1.5))
                expect(geom.radius).to(equal(0.5))
            }
        }

        it("should have a green slightly transparent sphere") {
            expect(subject.childNodes.count).to(equal(1))
            if let node = subject.childNodes.first as? SCNNode {
                expect(node.geometry).to(beAnInstanceOf(SCNSphere.self))
                if let geom = node.geometry as? SCNSphere {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let diffuse = mat.diffuse.contents as! NSColor
                        expect(diffuse).to(equal(NSColor.treeGreen()))
                        let transparent = mat.transparent.contents as! NSColor
                        expect(transparent).to(equal(NSColor(calibratedWhite: 0.9, alpha: 1.0)))
                    }
                    expect(geom.radius).to(equal(1))
                }

                expect(node.position).to(equal(SCNVector3Make(0, 1.25, 0)))
                expect(SCNMatrix4EqualToMatrix4(node.pivot, SCNMatrix4MakeTranslation(0, -0.25, 0))).to(beTruthy())
            }
        }

        describe("shaking") {
            beforeEach {
                subject.shake()
            }

            it("should add an action to the leavesNode") {
                expect(subject.leavesNode?.actionForKey("Shake")).toNot(beNil())
            }
        }
    }
}
