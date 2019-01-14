//
//  GameViewController.swift
//  FlappyDragon
//
//  Created by Matheus Lima on 13/01/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var stage: SKView!

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = view as? SKView
        /* Disable auto order */
        stage.ignoresSiblingOrder = true
        
        presentScene()
    }
    
    func presentScene() {
        let scene = GameScene(size: CGSize(width: 320, height: 568))
        scene.scaleMode = .aspectFill
        
        stage.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
