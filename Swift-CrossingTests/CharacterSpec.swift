import Quick
import Nimble
import SceneKit

class CharacterSpec: QuickSpec {
    override func spec() {
        var subject : Character! = nil

        beforeEach {
            subject = Character()
        }

        describe("Creating a new characeter") {
            it("should default to a white box with a brown front") {
                let node = subject.contents
                expect(node.geometry).to(beAnInstanceOf(SCNBox.self))
                if let geom = node.geometry {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let color = mat.diffuse.contents as NSColor
                        expect(color).to(equal(NSColor.brownColor()))
                    }
                    for var i = 1; i < (geom.materials?.count ?? 0); i++ {
                        let color = geom.materials![i].diffuse.contents as NSColor
                        expect(color).to(equal(NSColor.whiteColor()))
                    }
                }
            }

            it("should attach a dynamic physics body") {
                expect(subject.contents.physicsBody).toNot(beNil())
                if let body = subject.contents.physicsBody {
                    expect(body.type).to(equal(SCNPhysicsBodyType.Dynamic))
                }
            }
        }

        describe("Moving a character") {
            var expectVector : (SCNVector3) -> (Void) = {(vector) in
                expect(subject.contents.physicsBody?.velocity).toNot(beNil())
                if let vel = subject.contents.physicsBody?.velocity {
                    let isTrue = (fabs(vel.x - vector.x) < 1e-12) && (fabs(vel.y - vector.y) < 1e-12) && (fabs(vel.z - vector.z) < 1e-12)
                    expect(isTrue).to(beTruthy())
                }
            }
            var expectStationary : (Void) -> (Void) = {
                expectVector(SCNVector3Zero)
            }

            var expectRotation : (SCNVector3) -> (Void) = {(rotation) in
                expect(SCNVector3EqualToVector3(subject.contents.eulerAngles, rotation)).to(beTruthy())
            }

            it("should start not moving") {
                expectStationary()
            }

            it("should allow the character to move left") {
                subject.moveCharacter(-1, 0)
                expectVector(SCNVector3Make(-1, 0, 0))
            }

            it("should allow the character to move up") {
                subject.moveCharacter(0, 1)
                expectVector(SCNVector3Make(0, 0, 1))
            }

            it("should allow the character to move right") {
                subject.moveCharacter(1, 0)
                expectVector(SCNVector3Make(1, 0, 0))
            }

            it("should allow the character to move down") {
                subject.moveCharacter(0, -1)
                expectVector(SCNVector3Make(0, 0, -1))
            }

            it("should allow the character to move in two (non-opposite) directions") {
                subject.moveCharacter(1, 0)
                subject.moveCharacter(0, 1)
                let x = CGFloat(sqrt(0.5))
                expectVector(SCNVector3Make(x, 0, x))
            }

            context("When not running") {
                it("should not move more than 1 unit/second") {
                    subject.moveCharacter(2, 0)
                    expectVector(SCNVector3Make(1, 0, 0))
                }

                it("should normalize to no faster than 1 unit/second") {
                    subject.moveCharacter(1, 1)
                    let x = CGFloat(sqrt(0.5))
                    expectVector(SCNVector3Make(x, 0, x))
                }
            }

            context("When running") {
                beforeEach {
                    subject.toggleRunning()
                }

                it("should double the speeds inputted") {
                    subject.moveCharacter(1, 0)
                    expectVector(SCNVector3Make(2, 0, 0));
                }
            }
        }
    }
}
