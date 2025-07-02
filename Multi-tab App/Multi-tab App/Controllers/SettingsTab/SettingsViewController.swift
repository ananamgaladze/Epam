//
//  SettingsViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigation is easy!"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            toggleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor),
            toggleSwitch.leadingAnchor.constraint(equalTo: toggleLabel.trailingAnchor, constant: 20)
        ])
    }
}

#Preview {
    SettingsViewController()
}
