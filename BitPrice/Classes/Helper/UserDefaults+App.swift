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

    func reference() -> ReferenceTypeAPI {
        let storedValue = value(forKey: Key.referenceType)
        var type: ReferenceTypeAPI?

        if let storedValue = storedValue {
            let value = storedValue as? String ?? ReferenceTypeAPI.week.rawValue
            type = ReferenceTypeAPI(rawValue: value)
        }

        return type ?? ReferenceTypeAPI.week
    }

    func setReference(_ type: ReferenceTypeAPI) {
        set(type.rawValue, forKey: Key.referenceType)
    }

}
