//
//  GymClassCell.swift
//  Gym Schedule App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

protocol GymClassCellDelegate: AnyObject {
    func didTapRegisterButton(cell: GymClassCell)
}

final class GymClassCell: UITableViewCell {

    static let identifier = "GymClassCell"
    weak var delegate: GymClassCellDelegate?

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemPink
        return label
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemIndigo
        return label
    }()

    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let trainerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        return imageView
    }()

    private let trainerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemPurple
        return label
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 36),
            button.heightAnchor.constraint(equalToConstant: 36)
        ])
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()

        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        let timeStack = UIStackView(arrangedSubviews: [timeLabel, durationLabel])
        timeStack.axis = .vertical
        timeStack.spacing = 2

        let nameStack = UIStackView(arrangedSubviews: [heartButton, nameLabel])
        nameStack.axis = .horizontal
        nameStack.spacing = 8
        nameStack.alignment = .center

        let trainerStack = UIStackView(arrangedSubviews: [trainerImageView, trainerNameLabel])
        trainerStack.axis = .horizontal
        trainerStack.spacing = 8
        trainerStack.alignment = .center

        let middleStack = UIStackView(arrangedSubviews: [nameStack, trainerStack])
        middleStack.axis = .vertical
        middleStack.spacing = 4

        let mainStack = UIStackView(arrangedSubviews: [timeStack, middleStack, registerButton])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.distribution = .equalSpacing
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    @objc private func registerTapped() {
        delegate?.didTapRegisterButton(cell: self)
    }

    @objc private func heartTapped() {
        let isFavorited = heartButton.tintColor == .systemRed
        heartButton.setImage(UIImage(systemName: isFavorited ? "heart" : "heart.fill"), for: .normal)
        heartButton.tintColor = isFavorited ? .systemGray : .systemRed
    }


    func configure(with gymClass: GymClass) {
        timeLabel.text = gymClass.time
        durationLabel.text = gymClass.duration
        nameLabel.text = gymClass.name
        trainerNameLabel.text = gymClass.trainerName
        trainerImageView.image = gymClass.trainerImage

        let icon = gymClass.isRegistered ? "xmark" : "plus"
        registerButton.setImage(UIImage(systemName: icon), for: .normal)

        contentView.backgroundColor = gymClass.isRegistered ? UIColor.lightBlue : .systemBackground
    }
}

