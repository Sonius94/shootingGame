//
//  ScenarioHandler.swift
//  shootemall
//
//  Created by Tom Kastek on 22.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class ScenarioHandler {
    static let shared = ScenarioHandler()
    
    var currentScenario: Scenario = .firstWorld
    
    func getAvailableScenario(byIndex: Int) -> Scenario {
        if byIndex == 0 {
            return .firstWorld
        } else if byIndex == 1 {
            return .secondWorld
        }
        return .firstWorld
    }
    
    func getAvailableScenariosCount() -> Int {
        return enumCount(Scenario.self)
    }
    
    fileprivate func enumCount<T: Hashable>(_: T.Type) -> Int {
        var i = 1
        while (withUnsafePointer(to: &i, {
            return $0.withMemoryRebound(to: T.self, capacity: 1, { return $0.pointee })
        }).hashValue != 0) {
            i += 1
        }
        return i
    }
}

enum Scenario {
    case firstWorld, secondWorld
    
    static let allValues = [firstWorld, secondWorld]
    
    func getDescriptionImage() -> UIImage {
        let desImage: UIImage?
        switch self {
        case .firstWorld:
            desImage = UIImage(named: "defender_cat")!
        case .secondWorld:
            desImage = UIImage(named: "defender_dog")!
        }
        guard desImage != nil else {
            return UIImage()
        }
        return desImage!
    }
    
    func getDescriptionLabel() -> String {
        switch self {
        case .firstWorld:
            return NSLocalizedString("CatWorldDescription", comment: "")
        case .secondWorld:
            return NSLocalizedString("DogWorldDescription", comment: "")
        }
    }
}

