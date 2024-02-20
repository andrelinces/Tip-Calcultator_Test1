//
//  LogoView.swift
//  Tip-Calcultator_Test1
//
//  Created by Andre Linces on 2/19/24.
//

import UIKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {///ImageView the Logoview.
        let view = UIImageView(image: .init(named: "icCaculatorBW"))
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
    

    
    
    private let hStackView: UIStackView = {///Horizontal stackview for the logoview imageview and labels.
        let stackView = UIStackView(arrangedSubviews: [
        
        
        
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    
    
    init() {
        super.init(frame: .zero)///let's pass it zero because we're going to use auto layout so we don't really care about frames.
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private var logoViewLabel: UILabel = {
//        var label = UILabel()
//        label.text = "Testing"
//
//        return label
//    }()
    
    private func layout() {
        
        backgroundColor = .red
        
    }
     
}


