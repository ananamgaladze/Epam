//
//  OnboardingViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var isRestartMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()

    }

    private func setupConstraints() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupActions() {
        let action = UIAction { [weak self] _ in
            self?.navigateToPersonalInfo()
        }
        startButton.addAction(action, for: .touchUpInside)
    }

    private func setupButton() {
        setupConstraints()
        setupActions()
    }
    
    private func navigateToPersonalInfo() {
        let personalInfoVC = PersonalInfoViewController()
        personalInfoVC.delegate = self
        navigationController?.pushViewController(personalInfoVC, animated: false)
    }

    func updateToRestart() {
        isRestartMode = true
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .green
    }
}

// MARK: - OnboardingFlowDelegate

protocol OnboardingFlowDelegate: AnyObject {
    func onboardingDidFinish()
}

extension OnboardingViewController: OnboardingFlowDelegate {
    func onboardingDidFinish() {
        navigationController?.popToRootViewController(animated: false)
        updateToRestart()
    }
}


