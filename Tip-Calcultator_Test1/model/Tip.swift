//
//  Tip.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/28/24.
//

import Foundation

///so build a tip button rather than passing in some kind of text over here, I'm going to pass in a tip enum.
enum Tip {
    case nome
    case tenPercent
    case fifteenPercent
    case TwentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .nome:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .TwentyPercent:
            return "20%"
        case .custom(let value):
            return String(value)
        }
    }
}
