//
//  Double+Extension.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 3/11/24.
//

import Foundation

extension Double { // So basically what it does is that it checks. If this is a whole number, then do not add the decimal point.
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? "" 
    }
}
