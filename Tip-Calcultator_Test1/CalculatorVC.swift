//
//  ViewController.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/14/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

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
    
    /// We want to be able to add a gesture recognizer to the view itself.
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = { /// So for instance, if the user taps on the view, we don't need to send in any kind of string or integer and therefore we can set this as void.
        let tapGesture = UITapGestureRecognizer(target: self, action: nil) /// But this time we don't need to pass into the action so we can just set this to be now
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in /// it converts one publisher to a different publisher.
            Just(())   ///We can just use a just, just and then to represent the void, we can just use this. So we are basically just converting this into a void.
        }.eraseToAnyPublisher()
    }()
    
    /// We want to be able to add a gesture recognizer to the LogoView itself and reset the fields.
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2 /// And to differentiate this TAB publisher from the first one, I'm going to set the number of tabs required to be two.
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        bind()
        observe()
    }
    
    private func bind() { /// Function to bind the values ​​passed between Viewcontroller and CalculatorVM
        
        //testing... Passing viewcontroller values.
//        billImputView.valuePublisher.sink { bill in
//            print("bill: \(bill)")
//        }.store(in: &cancellables)
        
        let input = CalculatorVM.Input(
            billPublisher: billImputView.valuePublisher, /// Just(500).eraseToAnyPublisher() TEST VALUES
            tipPublisher: tipImputView.valuePublisher,
            splitPublisher: splitImputView.valuePusblisher,   ///Just(5).eraseToAnyPublisher()) TEST VALUES
            logoViewTapPublisher: logoViewTapPublisher,
            viewTapPublisher: viewTapPublisher)
            
        let output = vm.transform(input: input)
        
        
        output.updateViewPublisher.sink { [unowned self] result in /// So when you call the same method, we will receive any result that's being updated from the publisher.
            resultView.configure(result: result)
        }.store(in: &cancellables)
        
        
        output.updateViewPublisher.sink { result in ///Observer the output
            print(">>>>> \(result)")
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [unowned self] _ in
            
            print("Hey reset the form please!")
            billImputView.reset()
            tipImputView.reset()
            splitImputView.reset()
            
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 5.0,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut) { /// So over here I want to expand the logo view.
                    self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
                } completion: { _ in
                    self.logoView.transform = .identity /// Let's bring it back to its original form, which is identity.
                }

            
        }.store(in: &cancellables)
        
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            view.endEditing(true)
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

