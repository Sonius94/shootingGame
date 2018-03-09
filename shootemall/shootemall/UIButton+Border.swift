//
//  UIBotton+Border.swift
//  shootemall
//
//  Created by Tom Kastek on 09.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

extension UIButton {
    func setButtonBorder() {
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.gray, for: .highlighted)
    }
}
