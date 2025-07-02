//
//  PhotoGalleryViewController.swift
//  Photo Gallery App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var images: [GalleryImage] = []
    private var groupedImages: [(key: String, value: [GalleryImage])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    private func setupData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        images = [
            GalleryImage(imageName: "i1", title: "Batumi", date: formatter.date(from: "2023/05/01")!, isFavorite: false),
            GalleryImage(imageName: "i2", title: "Bird", date: formatter.date(from: "2022/06/10")!, isFavorite: true),
            GalleryImage(imageName: "i3", title: "People", date: formatter.date(from: "2023/03/15")!, isFavorite: false),
            GalleryImage(imageName: "i4", title: "Tbilisi", date: formatter.date(from: "2022/01/05")!, isFavorite: false),
            GalleryImage(imageName: "i5", title: "Waterfall", date: formatter.date(from: "2023/08/21")!, isFavorite: true),
            GalleryImage(imageName: "i6", title: "Otaksa", date: formatter.date(from: "2023/08/21")!, isFavorite: false),
            GalleryImage(imageName: "i7", title: "Stars", date: formatter.date(from: "2023/08/21")!, isFavorite: false),
        ]
        groupImagesByYear()
    }

    private func groupImagesByYear() {
        let calendar = Calendar.current
        let groupedDict = Dictionary(grouping: images) {
            String(calendar.component(.year, from: $0.date))
        }
        groupedImages = groupedDict.sorted { $0.key > $1.key }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = false
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .zero
        collectionView.layoutMargins = .zero
        view.addSubview(collectionView)
    }

    private func imageAt(indexPath: IndexPath) -> GalleryImage {
        return groupedImages[indexPath.section].value[indexPath.item]
    }

    private func updateFavoriteStatus(at indexPath: IndexPath) {
        let title = groupedImages[indexPath.section].value[indexPath.item].title
        groupedImages[indexPath.section].value[indexPath.item].isFavorite.toggle()
        collectionView.reloadItems(at: [indexPath])
        let message = groupedImages[indexPath.section].value[indexPath.item].isFavorite
            ? "Marked \(title) as Favorite!"
            : "Removed \(title) from Favorites."
        showAlert(message: message)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            alert.dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var numberOfColumns: Int {
        let isPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
        return isPortrait ? 3 : 5
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupedImages[section].value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let image = imageAt(indexPath: indexPath)
        cell.configure(with: image)
        cell.onFavoriteTapped = { [weak self] in
            self?.updateFavoriteStatus(at: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        header.titleLabel.text = groupedImages[indexPath.section].key
        return header
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = CGFloat(numberOfColumns)
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (columns - 1)
        let horizontalInset: CGFloat = 10 * 2
        let totalWidth = collectionView.bounds.width - horizontalInset
        let itemWidth = floor((totalWidth - totalSpacing) / columns)
        return CGSize(width: itemWidth, height: itemWidth + 30)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
