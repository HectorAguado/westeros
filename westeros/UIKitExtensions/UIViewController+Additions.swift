//
//  UIViewController+Additions.swift
//  westeros
//
//  Created by Hector Aguado on 13/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
