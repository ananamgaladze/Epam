//
//  ProfileViewController.swift
//  Profile Page Layout
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mari"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mari N."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()


    private let followButton: UIButton = {
        let button = UIButton(type: .custom) 
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return button
    }()


    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer | Nature Lover | Dreamer"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private func createStatStack(title: String, value: String) -> UIStackView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        let headerStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, followButton])
        headerStack.axis = .horizontal
        headerStack.spacing = 12
        headerStack.alignment = .center
        headerStack.distribution = .equalSpacing

        let followers = createStatStack(title: "Followers", value: "2.1k")
        let following = createStatStack(title: "Following", value: "321")
        let posts = createStatStack(title: "Posts", value: "77")

        let statsStack = UIStackView(arrangedSubviews: [followers, following, posts])
        statsStack.axis = .horizontal
        statsStack.distribution = .equalSpacing

        let mainStack = UIStackView(arrangedSubviews: [headerStack, bioLabel, statsStack])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}
