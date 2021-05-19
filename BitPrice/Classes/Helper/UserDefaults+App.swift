//
//  UserDefaults+App.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 26/01/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {

    private struct Key {
        static let referenceType = "reference"
    }

    // MARK: - Reference

    func reference() -> ReferenceAPIType {
        let storedValue = value(forKey: Key.referenceType)
        var type: ReferenceAPIType?

        if let storedValue = storedValue {
            let value = storedValue as? String ?? ReferenceAPIType.week.rawValue
            type = ReferenceAPIType(rawValue: value)
        }

        return type ?? ReferenceAPIType.week
    }

    func setReference(_ type: ReferenceAPIType) {
        set(type.rawValue, forKey: Key.referenceType)
    }

}
