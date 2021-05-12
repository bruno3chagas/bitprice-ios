//
//  ViewController+FooterDelegate.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 27/01/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import UIKit

extension ViewController: FooterViewDelegate {

    func footerViewButtonDidSelect(type: ReferenceTypeAPI) {
        UserDefaults.standard.setReference(type)
        callMarketPriceService(reference: type)
    }

}
