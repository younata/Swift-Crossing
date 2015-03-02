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
            it("should default to a white box") {
                let node = subject.contents
                expect(node.geometry).to(beAnInstanceOf(SCNBox.self))
                if let geom = node.geometry {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let color = mat.diffuse.contents as NSColor
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
                    expect(SCNVector3EqualToVector3(vel, vector)).to(beTruthy())
                }
            }
            var expectStationary : (Void) -> (Void) = {
                expectVector(SCNVector3Zero)
            }
            it("should start not moving") {
                expectStationary()
            }
            context("keying down") {
                context("twice") {
                    beforeEach {
                        subject.keyDown(126)
                        subject.keyDown(126)
                    }
                    it("should not give the character a velocity of 2") {
                        expectVector(SCNVector3Make(0, 0, 1))
                    }
                }

                context("the up arrow") {
                    beforeEach {
                        subject.keyDown(126)
                    }
                    it("should tell the character to move into the screen") {
                        expectVector(SCNVector3Make(0, 0, -1))
                    }
                }

                context("the down arrow") {
                    beforeEach {
                        subject.keyDown(125)
                    }
                    it("should tell the character to move out of the screen") {
                        expectVector(SCNVector3Make(0, 0, 1))
                    }
                }

                context("the right arrow") {
                    beforeEach {
                        subject.keyDown(124)
                    }
                    it("should tell the character to move right") {
                        expectVector(SCNVector3Make(1, 0, 0))
                    }
                }

                context("the left arrow") {
                    beforeEach {
                        subject.keyDown(123)
                    }
                    it("should tell the character to move left") {
                        expectVector(SCNVector3Make(-1, 0, 0))
                    }
                }
            }

            context("key up") {
                context("the up arrow") {
                    beforeEach {
                        subject.keyDown(126)
                        subject.keyUp(126)
                    }
                    it("should counteract the previous key down") {
                        expectStationary()
                    }
                }

                context("the down arrow") {
                    beforeEach {
                        subject.keyDown(125)
                        subject.keyUp(125)
                    }
                    it("should counteract the previous key down") {
                        expectStationary()
                    }
                }

                context("the right arrow") {
                    beforeEach {
                        subject.keyDown(124)
                        subject.keyUp(124)
                    }
                    it("should counteract the previous key down") {
                        expectStationary()
                    }
                }

                context("the left arrow") {
                    beforeEach {
                        subject.keyDown(123)
                        subject.keyUp(123)
                    }
                    it("should counteract the previous key down") {
                        expectStationary()
                    }
                }
            }
        }
    }
}
