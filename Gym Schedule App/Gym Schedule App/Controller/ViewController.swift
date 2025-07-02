//
//  ViewController.swift
//  Gym Schedule App
//
//  Created by ana namgaladze on 02.07.25.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var gymClasses: [Date: [GymClass]] = [:]
    private var sortedDates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wellness Classes"
        setupTableView()
        loadSampleData()
    }
    
    private func setupTableView() {
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func loadSampleData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let data: [GymClass] = [
            GymClass(id: UUID(), name: "Stretching", date: formatter.date(from: "2025/02/21")!, time: "18:00", duration: "55m", trainerName: "Agata Wójcik", trainerImage: UIImage(named: "agata") ?? UIImage(), isRegistered: false),
            GymClass(id: UUID(), name: "Stretching", date: formatter.date(from: "2025/02/22")!, time: "10:00", duration: "55m", trainerName: "Luca Pietrzyk", trainerImage: UIImage(named: "Luca") ?? UIImage(), isRegistered: true),
            GymClass(id: UUID(), name: "Pilates", date: formatter.date(from: "2025/02/22")!, time: "15:00", duration: "45m", trainerName: "Agata Wójcik", trainerImage: UIImage(named: "agata") ?? UIImage(), isRegistered: false),
            GymClass(id: UUID(), name: "Stretching", date: formatter.date(from: "2025/02/24")!, time: "09:00", duration: "55m", trainerName: "Agata Wójcik", trainerImage: UIImage(named: "agata") ?? UIImage(), isRegistered: false)
        ]
        
        gymClasses = Dictionary(grouping: data, by: { $0.date })
        sortedDates = gymClasses.keys.sorted()
    }
    
    private func toggleRegistration(at indexPath: IndexPath) {
        let date = sortedDates[indexPath.section]
        var gymClass = gymClasses[date]![indexPath.row]
        gymClass.isRegistered.toggle()
        gymClasses[date]![indexPath.row] = gymClass
        
        let message = gymClass.isRegistered
        ? "You have registered to \(gymClass.name), see you there!"
        : "You have just cancelled \(gymClass.name) :("
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


//MARK: ---extension
extension ViewController: UITableViewDelegate, UITableViewDataSource, GymClassCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sortedDates[section]
        return gymClasses[date]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMM yyyy"
        return formatter.string(from: sortedDates[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier, for: indexPath) as? GymClassCell else {
            return UITableViewCell()
        }
        let date = sortedDates[indexPath.section]
        let gymClass = gymClasses[date]![indexPath.row]
        cell.configure(with: gymClass)
        cell.delegate = self
        return cell
    }
    
    func didTapRegisterButton(cell: GymClassCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            toggleRegistration(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            let date = self.sortedDates[indexPath.section]
            self.gymClasses[date]?.remove(at: indexPath.row)
            
            if self.gymClasses[date]?.isEmpty == true {
                self.gymClasses.removeValue(forKey: date)
                self.sortedDates.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
