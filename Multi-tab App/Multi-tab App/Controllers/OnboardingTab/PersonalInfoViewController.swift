//
//  PersonalInfoViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class PersonalInfoViewController: UIViewController {

    weak var delegate: OnboardingFlowDelegate?

    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let phoneField: UITextField = {
        let field = UITextField()
        field.placeholder = "Phone Number"
        field.keyboardType = .phonePad
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        view.addSubview(nameField)
        view.addSubview(phoneField)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.widthAnchor.constraint(equalToConstant: 250),

            phoneField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            phoneField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneField.widthAnchor.constraint(equalTo: nameField.widthAnchor),

            confirmButton.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        [nameField, phoneField].forEach {
            $0.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        }

        confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.handleConfirm()
        }), for: .touchUpInside)
    }

    @objc private func textFieldsChanged() {
        let nameValid = !(nameField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let phoneValid = (phoneField.text?.count ?? 0) >= 9

        let isValid = nameValid && phoneValid
        confirmButton.isEnabled = isValid
        confirmButton.backgroundColor = isValid ? .systemBlue : .gray
    }

    private func handleConfirm() {
        let name = nameField.text ?? ""
        let phone = phoneField.text ?? ""

        let alert = UIAlertController(
            title: "Confirm Information",
            message: "Please confirm your name and phone number: \nName: \(name)\nPhone: \(phone)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Edit", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            let preferencesVC = PreferencesViewController()
            preferencesVC.userData = (name, phone)
            preferencesVC.delegate = self?.delegate
            self?.navigationController?.pushViewController(preferencesVC, animated: true)
        })

        present(alert, animated: true)
    }
}
