//
//  ResultView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/19/24.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactor.build(
            text: "Total p/Person",
            font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    init() {
        super.init(frame: .zero)///let's pass it zero because we're going to use auto layout so we don't really care about frames.
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) { // Upadates the resultview with the calculated values.
        let text = NSMutableAttributedString(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let totalBillView: AmountView = { /// creating the reference to the accessible also of this hitch stack view.
        let view = AmountView(
            title: "Total bill",
            textAlignment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = { /// creating the reference to the accessible also of this hitch stack view.
        let view = AmountView(
            title: "Total tip",
            textAlignment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),///fill in the blank.
            totalTipView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally //.fillEqually cuting view
        return stackView
    }()
    
    private func layout() {///Testing the view with a color.
        backgroundColor = .white
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadon(///Extension to customize the UIView, with shadown, type similar to a card.. (ResultView)
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1)
    }
    private func buildSpacerView(height: CGFloat) -> UIView {///All right, so this is how I'll build a space view to add a bit of padding between this horizontal line
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
