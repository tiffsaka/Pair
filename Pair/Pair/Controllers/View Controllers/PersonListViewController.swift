//
//  PersonListViewController.swift
//  Pair
//
//  Created by Tiffany Sakaguchi on 5/21/21.
//

import UIKit
import CoreData

class PersonListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        PersonController.shared.fetchAndShuffleAllPeople()
    }

    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddPersonAlert()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        shuffleAndReloadData()
    }
    
    //MARK: - Functions
    
    private func shuffleAndReloadData() {
        PersonController.shared.shufflePeople()
        tableView.reloadData()
    }
    
    func presentAddPersonAlert() {
        
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter name..."
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else { return }
            PersonController.shared.addPerson(name: name)
            self.shuffleAndReloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}//End of class

extension PersonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PersonController.shared.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.getNumberOfRowsPerSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.shared.getEachPerson(indexPath: indexPath)
        cell.textLabel?.text = person.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.shared.peopleList[indexPath.row]
            PersonController.shared.deletePerson(person: personToDelete)
            shuffleAndReloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
}//End of extension
