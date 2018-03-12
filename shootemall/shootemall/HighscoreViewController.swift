//
//  HighscoreViewController.swift
//  shootemall
//
//  Created by Tom Kastek on 12.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let score = UserDefaults.standard.integer(forKey: "highscore")
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
