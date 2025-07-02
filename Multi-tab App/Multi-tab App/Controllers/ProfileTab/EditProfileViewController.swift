//
//  EditProfileViewController.swift
//  Multi-tab App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class EditProfileViewController: UIViewController {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit your profile"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("[EditProfile] viewDidLoad")
        view.backgroundColor = .systemGray6
        title = "Edit profile"
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("[EditProfile] viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[EditProfile] viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("[EditProfile] viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("[EditProfile] viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[EditProfile] viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[EditProfile] viewDidDisappear")
    }
}
