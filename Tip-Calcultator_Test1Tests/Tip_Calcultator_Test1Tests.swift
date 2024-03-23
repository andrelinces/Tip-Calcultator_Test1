//
//  Tip_Calcultator_Test1Tests.swift
//  Tip-Calcultator_Test1Tests
//
//  Created by Andre Linces on 2/14/24.
//

import XCTest
import Combine
@testable import Tip_Calcultator_Test1

final class Tip_Calcultator_Test1Tests: XCTestCase {

    // SUT - System Under Test
    private var sut: CalculatorVM! /// I have created this app in the MVVM architecture and therefore we have put all the business logic inside the calculator VM and therefore we are testing primarily for the calculator.
    private var cancellables: Set<AnyCancellable>! /// And since we're using combine, we also need the cancelable.
    
    private var mockAudioPlayerService: MockAudioPlayService! /// Instance of mockAudioPlayer to use in calling the "sut" initializer

    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    
    override func setUp() { /// So every time a test runs, the setup method is called and it creates an instance of the suit.
        mockAudioPlayerService = .init()
        sut = .init(audioPlayerService: mockAudioPlayerService)
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() { /// And when the test ends or finishes, it calls the tear method, which resets the suit.
        super.tearDown()
        sut = nil
        cancellables = nil
        mockAudioPlayerService = nil
        logoViewTapSubject = nil
    }
    
                //Where Testing?               When ?        What are we testing? ?
    func testUpdateViewPublisherCalculatorVM_WhenFilled_ResultWitoutTipFor1Person() { /// Testing bill without tip for 1 Person.
        
        // Arrange or Given
        
        let bill: Double = 100.0
        let tip: Tip = .nome
        let split: Int = 1
        let input =  buildInput(
            bill: bill,
            tip: tip,
            split: split
            )
        // Assert or When
        /// I'm going to do let output because we are testing for the output of the view model.
        let output = sut.transform(input: input) ///I'm going to create a function over here to build this input.
        
        
        // ACT or Then
        output.updateViewPublisher.sink { result in
            
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        
        }.store(in: &cancellables)
        
        
    }
    
    func testUpdateViewPublisherCalculatorVM_WhenFilled_ResultWitoutTipFor2Person() { /// Testing bill without tip for 2 Person.
        
        // Arrange or Given
        let bill: Double = 100.0
        let tip: Tip = .nome
        let split: Int = 2
        let input =  buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // Assert or When
        /// I'm going to do let output because we are testing for the output of the view model.
        let output = sut.transform(input: input) ///I'm going to create a function over here to build this input.
        
        // ACT or Then
        output.updateViewPublisher.sink { result in
            
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
            
        }.store(in: &cancellables)
    }
    
    
    func testUpdateViewPublisherCalculatorVM_WhenFilled_ResultWith10PercentTipFor2Person() {
        
        // Arrange or Given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input =  buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // Assert or When
        /// I'm going to do let output because we are testing for the output of the view model.
        let output = sut.transform(input: input) ///I'm going to create a function over here to build this input.
        
        // ACT or Then
        output.updateViewPublisher.sink { result in
            
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
            
        }.store(in: &cancellables)
    }
    
    func testUpdateViewPublisherCalculatorVM_WhenFilled_ResultWithCustomtTipFor4Person() {
        
        // Arrange or Given
        let bill: Double = 200.0
        let tip: Tip = .custom(value: 201)
        let split: Int = 4
        let input =  buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // Assert or When
        /// I'm going to do let output because we are testing for the output of the view model.
        let output = sut.transform(input: input) ///I'm going to create a function over here to build this input.
        
        // ACT or Then
        output.updateViewPublisher.sink { result in
            
            XCTAssertEqual(result.amountPerPerson, 100.25)
            XCTAssertEqual(result.totalBill, 401)
            XCTAssertEqual(result.totalTip, 201)
            
        }.store(in: &cancellables)
    }
    
    
    func testSoundPlayedAndResetCalculatorVM_WhenTappedLogoView_ResetOnLogoViewTapAndPlayedSound() {
        
        // Arrange or Given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "Reset calculator called")
        let expectation2 = mockAudioPlayerService.expectation
        
        
        // ACT or Then
        output.resetCalculatorPublisher.sink { result in
            expectation1.fulfill()
            
            
        }.store(in: &cancellables)
        
        // Assert or When
        ///because this is a synchronous code, I have to put the when at the bottom over here, when I fire the event, I'm expecting the events to be fulfilled inside this.
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
        
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input { ///I can take in the values from a parent here and construct this publishers using a just publisher.
        return .init(/// This input is a struct so I can do return.
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
    
}

class MockAudioPlayService: AudioPlayerService { /// Testing With Mock Audio Play service
    
    var expectation = XCTestExpectation(description: "Playsound is called")
    
    func playSound() {
        expectation.fulfill()
    }
    
    
}
