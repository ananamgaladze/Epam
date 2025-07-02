//
//  PhotoCell.swift
//  Photo Gallery App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let heartButton = UIButton(type: .system)

    var onFavoriteTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        setupViews()
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center

        heartButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        [imageView, titleLabel, heartButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            heartButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6)
        ])
    }

    func configure(with image: GalleryImage) {
        imageView.image = UIImage(named: image.imageName)
        titleLabel.text = image.title
        let iconName = image.isFavorite ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: iconName), for: .normal)
        heartButton.tintColor = image.isFavorite ? .systemRed : .label
    }

    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
