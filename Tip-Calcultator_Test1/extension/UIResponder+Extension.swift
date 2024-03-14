//
//  UIResponder+Extension.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 3/7/24.
//

import UIKit

extension UIResponder { ///And the way to do that is to check inside the UI view for the parent UIResponder.
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
