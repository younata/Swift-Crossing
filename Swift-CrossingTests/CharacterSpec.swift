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
                expect(subject.geometry).to(beAnInstanceOf(SCNBox.self))
                if let geom = subject.geometry {
                    expect(geom.firstMaterial).toNot(beNil())
                    if let mat = geom.firstMaterial {
                        let color = mat.diffuse.contents as! NSColor
                        expect(color).to(equal(NSColor.brownColor()))
                    }
                    for var i = 1; i < (geom.materials?.count ?? 0); i++ {
                        let color = geom.materials![i].diffuse.contents as! NSColor
                        expect(color).to(equal(NSColor.whiteColor()))
                    }
                }
            }

            it("should attach a dynamic physics body") {
                expect(subject.physicsBody).toNot(beNil())
                if let body = subject.physicsBody {
                    expect(body.type).to(equal(SCNPhysicsBodyType.Dynamic))
                }
            }
        }

        describe("Setting velocity") {
            it("should set the physicsBody velocity absolutely") {
                subject.velocity = Vector2(x: 0.5, z: 1)
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(0.5, 0, 1)))
            }
        }

        describe("Moving a character") {
            it("should start not moving") {
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Zero))
            }

            it("should allow the character to move left") {
                subject.moveCharacter(-1, 0)
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(-1, 0, 0)))
            }

            it("should allow the character to move up") {
                subject.moveCharacter(0, 1)
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(0, 0, 1)))
            }

            it("should allow the character to move right") {
                subject.moveCharacter(1, 0)
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(1, 0, 0)))
            }

            it("should allow the character to move down") {
                subject.moveCharacter(0, -1)
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(0, 0, -1)))
            }

            it("should allow the character to move in two (non-opposite) directions") {
                subject.moveCharacter(1, 0)
                subject.moveCharacter(0, 1)
                let x = CGFloat(sqrt(0.5))
                expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(x, 0, x)))
            }

            context("When not running") {
                it("should not move more than 1 unit/second") {
                    subject.moveCharacter(2, 0)
                    expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(1, 0, 0)))
                }

                it("should normalize to no faster than 1 unit/second") {
                    subject.moveCharacter(1, 1)
                    let x = CGFloat(sqrt(0.5))
                    expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(x, 0, x)))
                }
            }

            context("When running") {
                beforeEach {
                    subject.toggleRunning()
                }

                it("should double the speeds inputted") {
                    subject.moveCharacter(1, 0)
                    expect(subject.physicsBody?.velocity).to(equal(SCNVector3Make(2, 0, 0)))
                }
            }

            describe("Moving back to zero") {
                beforeEach {
                    subject.moveCharacter(1, 0)
                    subject.moveCharacter(-1, 0)
                }

                it("should set a velocity of (0, 0, 0)") {
                    expect(subject.physicsBody?.velocity).to(equal(SCNVector3Zero))
                }
            }
        }
    }
}
