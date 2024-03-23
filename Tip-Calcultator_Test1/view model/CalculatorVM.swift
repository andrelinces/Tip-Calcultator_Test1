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
        let logoViewTapPublisher: AnyPublisher<Void, Never> /// Because this has to match this viewController signature.
    //    let viewTapPublisher: AnyPublisher<Void, Never> /// Because this has to match this viewController signature.
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never> ///Updates the view controller.
        let resetCalculatorPublisher: AnyPublisher<Void, Never> /// Basically, we want it to reset the form so I can do let reset calculator, reset form, reset calculator
     //   let hidesViewTapPublisher: AnyPublisher<Void, Never>  /// Hides the keybord.
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let audioPlayerService: AudioPlayerService /// Dependency injection from audio player service.
    
    init(audioPlayerService: AudioPlayerService = defaultAudioPlayer()) { /// This is what is known as dependency injection whereby whenever we initialize the view model, we have to pass in the services that is dependent on.
        self.audioPlayerService = audioPlayerService
    }
    
    func transform(input: Input) -> Output {///Method for binding the view controller with the View model and to calculate the bill.
        
        //testing...BillImputView Passing viewcontroller values.
//        input.billPublisher.sink { billVM in  /// You notice that now inside the Transform method, I'm able to have access to the View.
//            print("billVM: \(billVM)")
//        }.store(in: &cancellables)
        
        //testing...TipImputView Passing viewcontroller values.
//                input.tipPublisher.sink { tipVM in  /// You notice that now inside the Transform method, I'm able to have access to the View.
//                    print("tipVM: \(tipVM)")
//                }.store(in: &cancellables)
        
        //testing...SplitImputView Passing viewcontroller values.
//                input.splitPublisher.sink { splitVM in  /// You notice that now inside the Transform method, I'm able to have access to the View.
//                    print("splitVM: \(splitVM)")
//                }.store(in: &cancellables)
        
        
        /// This is the function that you use to observe if any of these publishers change.
        let updateViewPublisher = Publishers.CombineLatest3( /// So since we are observing tree publishers, we're going to use combined latest three.
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in /// So I'm going to do a flat map because I have to transform this update view publisher into a type of any publisher result.
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()
                                                                 // Handle events to call the audio player service.
        let resetCalculatorPublisher = input.logoViewTapPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap {
            return Just(($0))
        }.eraseToAnyPublisher()
        
        
   //     let hidesViewTapPublisher = input.viewTapPublisher
        
        return Output(updateViewPublisher: updateViewPublisher, /// I can just pass in the publisher here
                      resetCalculatorPublisher: resetCalculatorPublisher
                     // hidesViewTapPublisher: hidesViewTapPublisher
        )
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double { /// Func to calculate, use the bill and then we multiply it by the tip percentage.
       
        switch tip {
        case .nome:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .TwentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
        
    }
    
}
