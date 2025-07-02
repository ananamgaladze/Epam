//
//  GymClassModel.swift
//  Gym Schedule App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

struct GymClass {
    let id: UUID
    let name: String
    let date: Date
    let time: String
    let duration: String
    let trainerName: String
    let trainerImage: UIImage
    var isRegistered: Bool
}
