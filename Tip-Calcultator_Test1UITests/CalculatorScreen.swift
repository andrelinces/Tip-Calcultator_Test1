//
//  CalculatorScreen.swift
//  Tip-Calcultator_Test1UITests
//
//  Created by Andre Linces on 3/23/24.
//

import XCTest

class CalculatorScreen {
    
    private let app: XCUIApplication!
    
    init(app: XCUIApplication!) {
        self.app = app
    }
    
    // LogoView
    var logoView: XCUIElement { // OtherElements for just the LogoView view, without specifying one by one of the elements.
        return logoView.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    
    // ResultView
    var totalAmountPerPersonValueLabel: XCUIElement { // So this is how we reference these this label from the ResultView.
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue] // statictext to represent the labels.
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // BillInputView
    var billInputViewTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    
    
}

