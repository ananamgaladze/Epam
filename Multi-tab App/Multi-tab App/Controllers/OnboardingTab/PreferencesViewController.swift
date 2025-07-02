//
//  PreferencesViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class PreferencesViewController: UIViewController {

    weak var delegate: OnboardingFlowDelegate?
    var userData: (String, String)?

    private let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Notification Preference", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let selectedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.isEnabled = false
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var selectedPref: String? {
        didSet {
            let isValid = selectedPref != nil
            nextButton.isEnabled = isValid
            nextButton.backgroundColor = isValid ? .systemBlue : .gray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        view.addSubview(selectButton)
        view.addSubview(selectedLabel)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            selectButton.widthAnchor.constraint(equalToConstant: 280),
            selectButton.heightAnchor.constraint(equalToConstant: 44),

            selectedLabel.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 20),
            selectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nextButton.topAnchor.constraint(equalTo: selectedLabel.bottomAnchor, constant: 30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: selectButton.widthAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        selectButton.addAction(UIAction(handler: { [weak self] _ in
            self?.showActionSheet()
        }), for: .touchUpInside)

        nextButton.addAction(UIAction(handler: { [weak self] _ in
            self?.goToConfirmDetails()
        }), for: .touchUpInside)
    }

    private func showActionSheet() {
        let alert = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)
        ["Email Notifications", "SMS Notifications", "Push Notifications"].forEach { pref in
            alert.addAction(UIAlertAction(title: pref, style: .default) { [weak self] _ in
                self?.selectedPref = pref
                self?.selectedLabel.text = "Selected: \(self?.selectedPref ?? "")"
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: false)
    }

    private func goToConfirmDetails() {
        guard let userData = userData, let pref = selectedPref else { return }
        let confirmVC = ConfirmDetailsViewController(name: userData.0, phone: userData.1, preference: pref)
        confirmVC.delegate = delegate
        navigationController?.pushViewController(confirmVC, animated: false)
    }
}
