//
//  Task2.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    //MARK: ---properties
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Aniko"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let centeredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: ---life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: ---setup
    private func setupView() {
        setTopLabel()
        setCenteredButton()
    }
    
    private func setTopLabel() {
        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setCenteredButton() {
        view.addSubview(centeredButton)
        NSLayoutConstraint.activate([
            centeredButton.topAnchor.constraint(equalTo: topLabel.bottomAnchor,constant: 30),
            centeredButton.widthAnchor.constraint(equalToConstant: 120),
            centeredButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

#Preview {
    Task2ViewController()
}
