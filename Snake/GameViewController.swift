//
//  GameViewController.swift
//  Snake
//
//  Created by Kim Ilya on 10/05/2020.
//  Copyright © 2020 rstarfir. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let scene = GameScene(size: view.bounds.size)
    
    let skView = view as! SKView
    
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    skView.presentScene(scene)
  }
}
