//
//  CalculatorVM.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/29/24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {///I'm going to take this information over here in the form of a publisher.
        let billPublisher: AnyPublisher<Double, Never> ///So the reason why I put NEVER over here is because this publisher will never return a failure.
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never> ///Updates the view controller.
        
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {///Method for binding the view controller with the View model.
        
        //testing... Passing viewcontroller values.
//        input.billPublisher.sink { billVM in  /// You notice that now inside the Transform method, I'm able to have access to the View.
//            print("billVM: \(billVM)")
//        }.store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.0)
        
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
