//
//  ViewController.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/14/24.
//

import UIKit
import SnapKit
import Combine

class CalculatorVC: UIViewController {

    //Instancing the views created for the screen components.
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billImputView = BillImputView()
    private let tipImputView = TipImputView()
    private let splitImputView = SplitImputView()
    
    private var testView = UIView()
    
    /// Create a vertical stackview for the views.
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billImputView,
            tipImputView,
            splitImputView,
            UIView()///To fix xcode constraints error, about unused space in stackView.
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let vm = CalculatorVM()
    private var cancellables = Set<AnyCancellable>() ///Store values output, so that we have a reference to hold this
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        bind()
    }
    
    private func bind() { /// Function to bind the values ​​passed between Viewcontroller and CalculatorVM
        
        //testing... Passing viewcontroller values.
//        billImputView.valuePublisher.sink { bill in
//            print("bill: \(bill)")
//        }.store(in: &cancellables)
        
        let input = CalculatorVM.Input(
            billPublisher: billImputView.valuePublisher, /// Just(500).eraseToAnyPublisher() TEST VALUES
            tipPublisher: tipImputView.valuePublisher,
            splitPublisher: Just(5).eraseToAnyPublisher())
        
        let output = vm.transform(input: input)
        
        output.updateViewPublisher.sink { result in ///Observer the output
            print(">>>>> \(result)")
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)///Add vStackView to main view.

        ///So we're going to use SNAP kit to help us to perform this auto layout.
        vStackView.snp.makeConstraints { make in

            make.leading.equalTo(view.snp.leadingMargin).offset(16)///So we want to use the margin constraint so that in case if the if the user rotates the phone
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }

        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }

        billImputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        tipImputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16) /// Obviously, I can add all the numbers up and put a number inside, but I did this because I wanted to, to show that I can do it like this.

        }

        splitImputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

    }
    
    

}

