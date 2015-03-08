import Quick
import Nimble
import SceneKit

class FakeCharacter : Character {
    var x: CGFloat? = nil
    var z: CGFloat? = nil
    var running: Bool = false

    override func moveCharacter(x: CGFloat, _ z: CGFloat) {
        self.x = x
        self.z = z
    }

    override func toggleRunning() {
        running = !running
    }
}

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

            it("should setup a landscape") {
                expect(subject.scene?.rootNode.childNodesPassingTest() {(node, stop) in
                    return node is LandScape
                }.count).to(equal(1))
            }

            it("should have an ocean") {
                let nodes = subject.scene?.rootNode.childNodesPassingTest() {(node, stop) in
                    return node is Ocean
                }
                expect(nodes?.count).to(equal(1))
                if let ocean = nodes?.first as? Ocean {
                    expect(ocean.position).to(equal(SCNVector3Make(0, 0, 55)))
                }
            }

            it("should create a character") {
                expect(subject.character).toNot(beNil())
                expect(subject.character?.parentNode).to(equal(subject.scene?.rootNode))
            }

            it("should create a tree or 3") {
                expect(subject.trees.count).toNot(equal(0))

                expect(subject.scene?.rootNode.childNodesPassingTest() {(node, stop) in
                    return node is Tree
                }.count).toNot(equal(0))
            }

            describe("the cameraNode") {
                it("should exist and have a camera") {
                    expect(subject.cameraNode).toNot(beNil())

                    expect(subject.cameraNode?.parentNode).toNot(beNil())
                    expect(subject.cameraNode?.parentNode).to(equal(subject.character))

                    expect(subject.cameraNode?.camera).toNot(beNil())
                }

                it("should look at the character") {
                    expect(subject.cameraNode?.constraints).toNot(beNil())
                    if let constraints = subject.cameraNode?.constraints {
                        expect(constraints.count).to(equal(1))
                        if let lookAt = constraints.first as? SCNLookAtConstraint {
                            expect(lookAt.target).toNot(beNil())
                            expect(lookAt.target).to(equal(subject.character))
                            expect(lookAt.gimbalLockEnabled).to(beFalsy())
                        }
                    }
                }
            }
        }

        describe("Keying") {

            var char: FakeCharacter! = nil

            var eventFactory : (UInt16, NSEventType) -> (NSEvent) = {(keyCode, type) in
                return NSEvent.keyEventWithType(type,
                    location: NSMakePoint(0,0),
                    modifierFlags: NSEventModifierFlags.allZeros,
                    timestamp: 0,
                    windowNumber: 0,
                    context: nil,
                    characters: "",
                    charactersIgnoringModifiers: "",
                    isARepeat: false,
                    keyCode: keyCode)!
            }

            var charMove : (CGFloat, CGFloat) -> (Void) = {(x, z) in
                let isTrue = char.x == x && char.z == z
                expect(isTrue).to(beTruthy())
            }

            beforeEach {
                char = FakeCharacter() as FakeCharacter
                subject.character = char
            }

            describe("Down") {
                it("the up arrow should tell the character to go up") {
                    subject.keyDown(eventFactory(126, .KeyDown))

                    charMove(0, -1)
                }

                it("the down arrow should tell the character to go down") {
                    subject.keyDown(eventFactory(125, .KeyDown))

                    charMove(0, 1)
                }

                it("the left arrow should tell the character to go left") {
                    subject.keyDown(eventFactory(123, .KeyDown))

                    charMove(-1, 0)
                }

                it("the right arrow should tell the character to go right") {
                    subject.keyDown(eventFactory(124, .KeyDown))

                    charMove(1, 0)
                }
            }

            describe("Up") {
                it("the up arrow should tell the character to stop going up") {
                    subject.keyUp(eventFactory(126, .KeyUp))

                    charMove(0, 1)
                }

                it("the down arrow should tell the character to stop going down") {
                    subject.keyUp(eventFactory(125, .KeyUp))

                    charMove(0, -1)
                }

                it("the left arrow should tell the character to stop going left") {
                    subject.keyUp(eventFactory(123, .KeyUp))

                    charMove(1, 0)
                }

                it("the right arrow should tell the character to stop going right") {
                    subject.keyUp(eventFactory(124, .KeyUp))
                    
                    charMove(-1, 0)
                }
            }
        }
    }
}