//
//  MenuViewController.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var newHighscoreLabel: UILabel!
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var highscoreButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newHighscoreLabel.alpha = 0
        startGameButton.setButtonBorder()
        highscoreButton.setButtonBorder()
    }
    
    func setScore(score: Int) {
        let oldHighscore = UserDefaults.standard.integer(forKey: "highscore")
        if score > oldHighscore {
            UserDefaults.standard.set(score, forKey: "highscore")
        }
        titleLabel.text = "Kills :\(score)"
    }
}
