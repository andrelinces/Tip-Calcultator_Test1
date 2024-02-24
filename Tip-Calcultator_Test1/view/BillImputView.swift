//
//  BillImputView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/19/24.
//

import UIKit

class BillImputView: UIView {
    
    private let headerView: UIView = {
        return HeaderView() /// Return HeaderView, provisionally and then inject the attributes and reuse it.
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8)///Corner radius at the edges of the view.
        return view
    }()
    
    private let currencyDemoninationLabel: UILabel = {
        let label = LabelFactor.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)///So what it means is that this currency denomination label will lock itself, Basically, it will be as small as possible.
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        // Add Toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        toolBar.items = [ UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil),
                                        doneButton
                          ]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    init() {
        super.init(frame: .zero)///let's pass it zero because we're going to use auto layout so we don't really care about frames.
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()/// Pins the headerView to the main view.
            make.centerY.equalTo(textFieldContainerView.snp.centerY) ///Pins the headerView in the center (centerY) of the textFieldContainerView.
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in /// we want to just pin this all the way, and then we allow the head of view to have the free.
            make.top.trailing.bottom.equalToSuperview()
        }
        
        ///added the view inside the text view container view.
        textFieldContainerView.addSubview(currencyDemoninationLabel)
        textFieldContainerView.addSubview(textField)
        
        ///I need to align the currency, a denomination label, to be on the left hand side of the container.
        currencyDemoninationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        //then we have to set the text view.
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            ///And then we want to have some padding between the container as well as the currency denomination label.
            make.leading.equalTo(currencyDemoninationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    @objc private func doneButtonTapped() {/// Function to create the button done action, in the billImputView's textField.
        textField.endEditing(true)
    }
     
}

class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
    }
}
