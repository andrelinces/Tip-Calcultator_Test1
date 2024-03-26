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
        app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    
    // ResultView
    
    var totalAmountPerPersonValueLabel: XCUIElement { // So this is how we reference these this label from the ResultView.
        app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue] // statictext to represent the labels.
    }
    
    var totalBillValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // BillInputView
    var billInputViewTextField: XCUIElement {
        app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // TipInputView
    var tenPercentTipButton: XCUIElement { // button to represent the button type.
        app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    var fifteenPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    var twentyPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    var customTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    var customTipAlertTextField: XCUIElement { // TextFields to represent the textFields type.
        app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    // SplitInputView
    var decrementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    var incrementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    var quantityLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // Actions
    
    func enterBill(amount: Double) { // So this is one of the actions of alert textField element.
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n") /// "\n , close keyboard"
    }
    
    func selectTip(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fifteenPercentTipButton.tap()
        case .twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0)) /// Ensure that the custom tip alert text view is showing up. Otherwise we are going to fail this UI test.
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(
            withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(
            withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
  
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
    
}

