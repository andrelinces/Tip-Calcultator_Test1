//
//  LabelFactor.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/20/24.
//

import UIKit

struct LabelFactor {
    
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.backgroundColor = backgroundColor
            label.textColor = textColor
            label.textAlignment = textAlignment
            return label
        }
}
