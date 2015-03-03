import Quick
import Nimble
import SceneKit

class GameViewSpec: QuickSpec {
    override func spec() {
        var subject : GameView! = nil

        beforeEach {
            subject = GameView()
            subject.setup()
        }

        describe("after setup") {
            it("should create a scene") {
                expect(subject.scene).toNot(beNil())
            }

            it("should create a character") {
                expect(subject.character).toNot(beNil())
                expect(subject.character?.contents.parentNode).to(equal(subject.scene?.rootNode))
            }

            describe("the cameraNode") {
                it("should exist and have a camera") {
                    expect(subject.cameraNode).toNot(beNil())

                    expect(subject.cameraNode?.parentNode).toNot(beNil())
                    expect(subject.cameraNode?.parentNode).to(equal(subject.character?.contents))

                    expect(subject.cameraNode?.camera).toNot(beNil())
                }

                it("should look at the character") {
                    expect(subject.cameraNode?.constraints).toNot(beNil())
                    if let constraints = subject.cameraNode?.constraints {
                        expect(constraints.count).to(equal(1))
                        if let lookAt = constraints.first as? SCNLookAtConstraint {
                            expect(lookAt.target).toNot(beNil())
                            expect(lookAt.target).to(equal(subject.character?.contents))
                            expect(lookAt.gimbalLockEnabled).to(beFalsy())
                        }
                    }
                }
            }
        }
    }
}