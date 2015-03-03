//
//  GameViewController.swift
//  Swift-Crossing
//
//  Created by Rachel Brindle on 3/1/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: GameView!
    
    override func awakeFromNib(){
        gameView.setup()
    }
}
