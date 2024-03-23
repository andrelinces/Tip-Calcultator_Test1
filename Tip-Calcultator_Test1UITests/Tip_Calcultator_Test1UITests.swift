//
//  Tip_Calcultator_Test1UITests.swift
//  Tip-Calcultator_Test1UITests
//
//  Created by Andre Linces on 2/14/24.
//

import XCTest

final class Tip_Calcultator_Test1UITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultView_WhenStartApp_ResultViewDefaultValues() {
        
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
        
    }
    
    
}
