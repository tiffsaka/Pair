//
//  Person+Convenience.swift
//  Pair
//
//  Created by Tiffany Sakaguchi on 5/21/21.
//

import CoreData

extension Person {
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
