//
//  PersonController.swift
//  Pair
//
//  Created by Tiffany Sakaguchi on 5/21/21.
//

import CoreData

class PersonController {

    static let shared = PersonController()
    var peopleList: [Person] = []
    
    private lazy var fetchRequest: NSFetchRequest<Person> = {
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    let maxNumberOfPeoplePerSection = 2
    
    var numberOfSections: Int {
        if peopleList.count % 2 == 0 {
            return (peopleList.count / maxNumberOfPeoplePerSection)
        } else {
            return ((peopleList.count / maxNumberOfPeoplePerSection) + 1)
        }
    }
    
    //MARK: - CRUD Functions
    
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        peopleList.append(newPerson)
        CoreDataStack.saveContext()
    }
    
    func fetchAndShuffleAllPeople() {
        peopleList = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        shufflePeople()
    }
    
    func shufflePeople() {
        peopleList = peopleList.shuffled()
    }
    
    func deletePerson(person: Person) {
        guard let index = peopleList.firstIndex(of: person) else { return }
        peopleList.remove(at: index)
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
    }
    
    //MARK: - Other Functions
        
    func getNumberOfRowsPerSection(section: Int) -> Int {
        if section == numberOfSections - 1 {
            return peopleList.count % 2 == 0 ? maxNumberOfPeoplePerSection : 1
        } else {
            return maxNumberOfPeoplePerSection
        }
    }
    
    func getEachPerson(indexPath: IndexPath) -> Person {
        let index = indexPath.section * maxNumberOfPeoplePerSection + indexPath.row
        return peopleList[index]
    }
    
}
