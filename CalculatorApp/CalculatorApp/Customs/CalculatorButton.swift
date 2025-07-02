//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by ana namgaladze on 27.06.25.
//

import UIKit

final class CalculatorButton: UIButton {
    
    private var action: (() -> Void)?
    
    init(title: String, backgroundColor: UIColor, action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.action = action
        
        // Add action
        addAction(UIAction(handler: { _ in
            action()
        }), for: .touchUpInside)
        
        // Fixed size
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 70),
            self.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        //circular
        self.layer.cornerRadius = 35
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
