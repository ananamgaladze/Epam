//
//  ProfileViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class ProfileViewController: UIViewController {

    private var userName: String = "Default" {
        didSet {
            nameLabel.text = userName
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("[Profile] viewDidLoad")
        title = "Profile"
        addSubviews()
        setupConstraints()
        setupActions()
        setupNavBarButtons()
        nameLabel.text = userName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[Profile] viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[Profile] viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[Profile] viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[Profile] viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[Profile] viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[Profile] viewDidDisappear")
    }

    private func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupActions() {
        editProfileButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateToEdit()
        }), for: .touchUpInside)
    }

    private func setupNavBarButtons() {
        let pencilAction = UIAction { [weak self] _ in
            self?.presentRenameAlert()
        }
        let anonAction = UIAction { [weak self] _ in
            self?.userName = "Anonymous"
        }

        let pencilItem = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), primaryAction: pencilAction, menu: nil)
        let anonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), primaryAction: anonAction, menu: nil)

        navigationItem.rightBarButtonItems = [anonItem, pencilItem]
    }

    private func presentRenameAlert() {
        let alert = UIAlertController(title: "Change Name", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Enter new name" }

        let confirm = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            let newName = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.userName = newName?.isEmpty == false ? newName! : "Default"
        }

        alert.addAction(confirm)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func navigateToEdit() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

