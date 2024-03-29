//
//  LogoView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/19/24.
//

import UIKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {///ImageView the Logoview.
        let view = UIImageView(image: .init(named: "icCalculatorBW"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactor.build(
            text: "Calculator",
            font: ThemeFont.demibold(ofSize: 20),
            textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = -4
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {///Horizontal stackview for the logoview imageview and labels.
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            vStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)///let's pass it zero because we're going to use auto layout so we don't really care about frames.
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func layout() {///add function for auto-layout
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in ///So this will pin to the to the top and the bottom of this logoView.
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in  ///to define the height of this stack view.
            make.height.equalTo(imageView.snp.width)
        }
    }
     
}


