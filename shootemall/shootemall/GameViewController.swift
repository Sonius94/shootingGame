//
//  GameViewController.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scenarioHandler: ScenarioHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        scene.gameVC = self
        scene.currentScenario = self.scenarioHandler?.currentScenario
        
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func gameOver(score: Int) {
        if let presenter = presentingViewController as? MenuViewController {
            presenter.setScore(score: score)
        }
        dismiss(animated: true, completion: nil)
    }
}

