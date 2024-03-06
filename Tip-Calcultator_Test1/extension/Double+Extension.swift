//
//  Double+Extension.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 3/1/24.
//

import Foundation

extension String {// So if this string value can be cast into a double, then you'll get a value.
    var  doubleValue: Double? {
        return Double(self) // Otherwise, it will be your return and name.
    }
}
