//
//  WorldTableViewCell.swift
//  shootemall
//
//  Created by Tom Kastek on 22.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class WorldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var scenario: Scenario?
    
    func configure(scenario: Scenario) {
        self.scenario = scenario
        self.descriptionImage.image = scenario.getDescriptionImage()
        self.descriptionLabel.text = scenario.getDescription()
    }
}

