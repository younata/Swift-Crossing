//
//  LandScape.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit

class LandScape : SCNNode {
    override init() {
        super.init()
        generateLandScape()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tiles : [[Tile]] = []
    var ocean : [[Ocean]] = []

    var weedTiles : [Tile] = []

    func addWeeds() {
        let maxNumberOfWeedsToAdd = 3

        var currentNumberOfWeeds = maxNumberOfWeedsToAdd

        func selectTile() -> Tile {
            var x = Int(arc4random_uniform(UInt32(tiles.count)))

            let row = tiles[x]

            let y = Int(arc4random_uniform(UInt32(tiles.count)))

            return row[y]
        }

        while currentNumberOfWeeds > 0 {
            let tile = selectTile()
            if contains(weedTiles.map({$0.location}), tile.location) {
                continue;
            }
            let weed = Weed()
            tile.addChildNode(weed)
            weedTiles.append(tile)
            currentNumberOfWeeds--
        }
    }

    private func generateLandScape() {
        tiles = []
        for y in 0..<100 {
            var row : [Tile] = []
            for x in 0..<100 {
                let tile: Tile
                if y == 99 {
                    tile = Beach()
                } else {
                    tile = Tile()
                }
                addChildNode(tile)
                tile.location = Vector2(x: CGFloat(x - 50), z: CGFloat(y - 50))
                row.append(tile)
            }
            tiles.append(row)
        }

        for y in 0..<10 {
            var row : [Ocean] = []
            for x in 0..<120 {
                let o = Ocean()
                addChildNode(o)
                o.location = Vector2(x: CGFloat(x - 60), z: CGFloat(y + 50))
                row.append(o)
            }
            ocean.append(row)
        }

        addWeeds()

        for i in 0..<3 {
            let wall = SCNPlane(width: 15, height: 100)
            let wallMaterial = SCNMaterial()
            wallMaterial.diffuse.contents = NSColor.brownColor()
            wall.firstMaterial = wallMaterial
            let n = SCNNode(geometry: wall)
            n.name = "Wall"

            let angle = CGFloat(M_PI_2)

            if i == 0 { // left
                n.position = SCNVector3Make(-50, 7.5, 0)
                n.eulerAngles = SCNVector3Make(-angle, 0, -angle)
            } else if i == 1 { // back
                n.position = SCNVector3Make(0, 7.5, -50)
                n.eulerAngles = SCNVector3Make(0, 0, angle)
            } else if i == 2 { // right
                n.position = SCNVector3Make(50, 7.5, 0)
                n.eulerAngles = SCNVector3Make(angle, 0, -angle)
            }
            addChildNode(n)
            n.physicsBody = SCNPhysicsBody.staticBody()
        }
        physicsBody = SCNPhysicsBody.staticBody()
    }
}
