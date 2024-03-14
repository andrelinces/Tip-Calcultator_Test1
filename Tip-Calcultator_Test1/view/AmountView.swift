//
//  AmountView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/21/24.
//

import UIKit

class AmountView: UIView {///So I'm just going to create separate views, but this view will  be uses in the resultview. 
    
    ///I want to inject some properties inside, type title of the amountviews , So, I'm going to create those properties at the top over here, and then we're going to inject them inside.
    
    private let title: String
    private let textAlignment: NSTextAlignment ///So since I since I made this property a mandatory, I have to inject this inside the initialize.
    
    private lazy var titleLabel: UILabel = {
        LabelFactor.build(
            text: title, ///The label to be needs lazy var to access the injection.
            font: ThemeFont.demibold(ofSize: 16),
            textColor: ThemeColor.text,
            textAlignment: textAlignment)
        
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)
                           ], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    init(title: String, textAlignment: NSTextAlignment) {///Custom initializer to inject the attributes, text and textAlignment.
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero) ///.zero, because of  auto layout.
        layout()
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) { /// Configures of the values to bind to the resultView.
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in /// I don't need to have any form of padding, I'm going to pin the stack view to the edges of the view itself.
            make.edges.equalToSuperview()
        }
    }
}

