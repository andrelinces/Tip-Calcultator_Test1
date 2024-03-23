//
//  SplitImputView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/19/24.
//

import UIKit
import Combine
import CombineCocoa

class SplitImputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Split",
            bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            text: "-",
            corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])/// Changes the corner radius only on the outside of the left button, which will decrease.
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in /// So basically when the publisher is being fired, it's going to return a void, which we don't need, because this using _
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1) /// Tenary operatior:  Let me check if it's equals to one. If it's equal to one, let's let's return one. Otherwise, let's return split subject value minus one.
        }.assign(to: \.value, on:  splitSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])/// All right, so you can play around with this to define where the curves you want it to be on the button itself.
        button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on:  splitSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactor.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            backgroundColor: .white)
        label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
        return label
    }()
    
    private lazy var splitStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1) /// This is another way to initialize this, Starting the creation of constants to retrieve data from the view controller.
    var valuePusblisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher() /// removeDuplicates() = remove repeated numbers.
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero) /// let's pass it zero because we're going to use auto layout so we don't really care about frames.
        layout()
        observeUpdateSplitLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func reset() {
        splitSubject.send(1)
    }
    
    private func layout() {
        
        [headerView, splitStackView].forEach(addSubview(_:))
        
        splitStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in /// So increment button decrement button dot for each and I want to ensure that they are squarish.
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height) ///All right, so this is how we make them square.
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(splitStackView.snp.centerY)
            make.trailing.equalTo(splitStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
    }
    
    private func observeUpdateSplitLabel() {
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellable)
            
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
     
}
