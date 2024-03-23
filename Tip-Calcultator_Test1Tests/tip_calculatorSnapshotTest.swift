//
//  tip_calculatorSnapshotTest.swift
//  Tip-Calcultator_Test1Tests
//
//  Created by Andre Linces on 3/22/24.
//

import XCTest
import SnapshotTesting
@testable import Tip_Calcultator_Test1


final class tip_calculatorSnapshotTest: XCTestCase { ///So one caveat over here is that when we do record the master screenshot, we record it from a particular simulator and when we run the test we have to ensure that we're using the same simulator to run the test.
    
    private var screeWidth: CGFloat { // Using the Iphone 14 Pro Simulator
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView_WhenStartApp_SnapshotMainScreenLogoView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 48) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = LogoView()
        
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size)) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testResultView_WhenStartApp_SnapshotMainScreenInitialResultView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 224) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = ResultView()
        
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testResultView_WhenAfterFillingFields_SnapshotMainScreenWithValueResultView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 224) /// "48", value defined in the view controller.
        let result = Result(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60)
        // Assert or When
        
        let view = ResultView()
        view.configure(result: result)
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testBillInputView_WhenStartApp_SnapshotMainScreenInitialBillInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = BillImputView()
        
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testBillInputView_WhenAfterFillingFields_SnapshotMainScreenWithValueBillInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = BillImputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testTipInputView_WhenStartApp_SnapshotMainScreenInitialTipInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56+56+16) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = TipImputView()
        
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testTipInputView_WhenAfterFillingFields_SnapshotMainScreenSelectionTipInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56+56+16)
        
        // Assert or When
        
        let view = TipImputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
    
    func testSplitInputView_WhenStartApp_SnapshotMainScreenInitialSplitInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = SplitImputView()
        
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
      
    func testSplitInputView_WhenAfterFillingFields_SnapshotMainScreenWithSelectionSplitInputView() {
       
        // Arrange or Given
        let size = CGSize(width: screeWidth, height: 56) /// "48", value defined in the view controller.
        
        // Assert or When
        
        let view = SplitImputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        // ACT or Then
        
        assertSnapshot(matching: view, as: .image(size: size) ) /// "assertSnapshot" , we want the single one image. So let's also do record true.
    }
}


// - Add snapshot test with custom values
       // - https://stackoverflow.com/a/45297466/6181721
extension UIView { ///** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
