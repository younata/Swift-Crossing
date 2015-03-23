import Quick
import Nimble
import SceneKit

class LandScapeSpec: QuickSpec {
    override func spec() {
        var subject : LandScape! = nil

        beforeEach {
            subject = LandScape()
        }

        describe("adding weeds") {
            it("should add weeds") {
                expect(subject.weedTiles.count).to(equal(3))

                subject.addWeeds()

                expect(subject.weedTiles.count).to(equal(6))
            }
        }

        describe("Creating a new landscape") {
            it("should create a grid of 100x100 tiles") { // For now.
                expect(subject.tiles.count).to(equal(100))
                for (y, row) in enumerate(subject.tiles) {
                    expect(row.count).to(equal(100))
                    for (x, tile) in enumerate(row) {
                        if (y == 99) {
                            expect(tile).to(beAnInstanceOf(Beach.self))
                        } else {
                            expect(tile).toNot(beAnInstanceOf(Beach.self))
                        }
                        expect(tile.parentNode).to(equal(subject))
                        let pos = Vector2(x: CGFloat(x - 50), z: CGFloat(y - 50))
                        expect(tile.location).to(equal(pos))
                    }
                }
            }

            it("should create an ocean") {
                expect(subject.ocean.count).to(equal(10))
                for (y, row) in enumerate(subject.ocean) {
                    expect(row.count).to(equal(120))
                    for (x, tile) in enumerate(row) {
                        expect(tile).to(beAnInstanceOf(Ocean.self))
                        expect(tile.parentNode).to(equal(subject))
                        let pos = Vector2(x: CGFloat(x - 60), z: CGFloat(y + 50))

                    }
                }
            }

            it("have 3 brown walls (cliffs) on the back and sides that each extend up 10 units") {
                let childNodes = subject.childNodesPassingTest {(node, _) in node.name == "Wall" }
                expect(childNodes.count).to(equal(3))
                for (i,x) in enumerate(childNodes) {
                    expect(x.geometry).to(beAnInstanceOf(SCNPlane.self))
                    if let g = x.geometry as? SCNPlane {
                        expect(g.firstMaterial).toNot(beNil())
                        if let color = g.firstMaterial?.diffuse.contents as? NSColor {
                            expect(color).to(equal(NSColor.brownColor()))
                        }
                        expect(g.width).to(equal(15))
                        expect(g.height).to(equal(100))
                    } else {
                        expect(false).to(beTruthy())
                    }
                    let angle = CGFloat(M_PI_2)
                    if i == 0 {
                        expect(x.position).to(equal(SCNVector3Make(-50, 7.5, 0)))
                        expect(x.eulerAngles).to(equal(SCNVector3Make(-angle, 0, -angle)))
                    } else if i == 1 {
                        expect(x.position).to(equal(SCNVector3Make(0, 7.5, -50)))
                        expect(x.eulerAngles).to(equal(SCNVector3Make(0, 0, angle)))
                    } else if i == 2 {
                        expect(x.position).to(equal(SCNVector3Make(50, 7.5, 0)))
                        expect(x.eulerAngles).to(equal(SCNVector3Make(angle, 0, -angle)))
                    }
                    expect(x.physicsBody).toNot(beNil())
                    if let body = x.physicsBody {
                        expect(body?.type).to(equal(SCNPhysicsBodyType.Static))
                    }
                }
            }
        }
    }
}
