//
//  CGPoint+Normalization.swift
//  shootemall
//
//  Created by Tom Kastek on 10.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return divide(by: length())
    }
}

// MARK: Math against CGFloat
extension CGPoint {
    func divide(by scalar: CGFloat) -> CGPoint {
        return CGPoint(x: self.x / scalar, y: self.y / scalar)
    }
    
    func add(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
    
    func substract(by point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - point.x, y: self.y - point.y)
    }
    
    func multiply(by scalar: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * scalar, y: self.y * scalar)
    }
}
