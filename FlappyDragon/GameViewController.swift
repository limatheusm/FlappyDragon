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
import AVFoundation

class GameViewController: UIViewController {
    var stage: SKView!
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = view as? SKView
        /* Disable auto order */
        stage.ignoresSiblingOrder = true
        
        presentScene()
        playMusic()
    }
    
    func playMusic() {
        if let musicURL = Bundle.main.url(forResource: "music", withExtension: "m4a") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                musicPlayer.numberOfLoops = -1
                musicPlayer.volume = 0.3
                musicPlayer.play()
            } catch _ {
                
            }
        }
    }
    
    func presentScene() {
        let scene = GameScene(size: CGSize(width: 320, height: 568))
        scene.gameViewController = self
        scene.scaleMode = .aspectFill

        stage.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.5))
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
