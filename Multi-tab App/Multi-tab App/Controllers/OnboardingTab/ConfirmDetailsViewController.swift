//
//  ConfirmDetailsViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class ConfirmDetailsViewController: UIViewController {

    weak var delegate: OnboardingFlowDelegate?
    private let name: String
    private let phone: String
    private let preference: String

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startOverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Over", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let editPrefButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Preferences", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let editInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Personal Info", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(name: String, phone: String, preference: String) {
        self.name = name
        self.phone = phone
        self.preference = preference
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        setupActions()
        setLabelText()
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(startOverButton)
        view.addSubview(editPrefButton)
        view.addSubview(editInfoButton)
        view.addSubview(confirmButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            startOverButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40),
            startOverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            editPrefButton.topAnchor.constraint(equalTo: startOverButton.bottomAnchor, constant: 16),
            editPrefButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            editInfoButton.topAnchor.constraint(equalTo: editPrefButton.bottomAnchor, constant: 16),
            editInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            confirmButton.topAnchor.constraint(equalTo: editInfoButton.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        startOverButton.addAction(UIAction(handler: { [weak self] _ in
            self?.startOverTapped()
        }), for: .touchUpInside)

        editPrefButton.addAction(UIAction(handler: { [weak self] _ in
            self?.editPrefTapped()
        }), for: .touchUpInside)

        editInfoButton.addAction(UIAction(handler: { [weak self] _ in
            self?.editInfoTapped()
        }), for: .touchUpInside)

        confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.confirmTapped()
        }), for: .touchUpInside)
    }

    private func setLabelText() {
        infoLabel.text = """
        Name: \(name)
        Phone Number: \(phone)
        Notification Preference: \(preference)
        """
    }

    private func startOverTapped() {
        navigationController?.popToRootViewController(animated: false)
        delegate?.onboardingDidFinish()
    }

    private func editPrefTapped() {
        let vc = PreferencesViewController()
        vc.userData = (name, phone)
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: false)
    }

    private func editInfoTapped() {
        let vc = PersonalInfoViewController()
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: false)
    }

    private func confirmTapped() {
        let alert = UIAlertController(
            title: "Success",
            message: "You have successfully passed the onboarding!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.startOverTapped()
        })
        present(alert, animated: true)
    }
}
