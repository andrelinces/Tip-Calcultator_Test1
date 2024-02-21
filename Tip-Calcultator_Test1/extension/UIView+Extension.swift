//
//  UIView+Extension.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/21/24.
//

import UIKit

extension UIView {///Extension to customize the UIView, with shadown, type similar to a card.. (ResultView)
    
    func addShadon(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    
}
