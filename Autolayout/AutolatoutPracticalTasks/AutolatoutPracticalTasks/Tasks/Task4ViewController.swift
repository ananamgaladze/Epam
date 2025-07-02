//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

final class Task4ViewController: UIViewController {

    private let redView = UIView()
    private let blueView = UIView()

    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        registerForTraitChanges()
    }

    private func setupViews() {
        redView.backgroundColor = .systemRed
        blueView.backgroundColor = .systemBlue

        [redView, blueView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        verticalConstraints = [
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redView.widthAnchor.constraint(equalToConstant: 150),
            redView.heightAnchor.constraint(equalToConstant: 150),

            blueView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 20),
            blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueView.widthAnchor.constraint(equalToConstant: 150),
            blueView.heightAnchor.constraint(equalToConstant: 150),
        ]

        horizontalConstraints = [
            redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            redView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redView.widthAnchor.constraint(equalToConstant: 150),
            redView.heightAnchor.constraint(equalToConstant: 150),

            blueView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 20),
            blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blueView.widthAnchor.constraint(equalToConstant: 150),
            blueView.heightAnchor.constraint(equalToConstant: 150),
        ]

        updateConstraintsForCurrentTraits()
    }

    private func registerForTraitChanges() {
        let traits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(traits) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.updateConstraintsForCurrentTraits()
        }
    }

    private func updateConstraintsForCurrentTraits() {
        NSLayoutConstraint.deactivate(verticalConstraints + horizontalConstraints)

        if traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(verticalConstraints)
        } else if traitCollection.horizontalSizeClass == .compact &&
                    traitCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(horizontalConstraints)
        }
    }
}


#Preview {
    Task4ViewController()
}
