//
//  PersonService.swift
//  CoreDataDemo
//
//  Created by Kokpheng on 10/28/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import CoreData

class PersonService {
    
    // Create object
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    // Creates a new Person
    func create(name: String, age: NSNumber, profile: NSData) -> Person {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName(Person.entityName, inManagedObjectContext: context) as! Person
        
        newItem.name = name
        newItem.age = age
        newItem.profile = profile
   
        return newItem
    }
    
    // Gets a person by id
    func getById(id: NSManagedObjectID) -> Person? {
        return context.objectWithID(id) as? Person
    }
    
    // Gets all that fulfill the specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    func get(withPredicate queryPredicate: NSPredicate) -> [Person]{
        
        let fetchRequest = NSFetchRequest(entityName: Person.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.executeFetchRequest(fetchRequest)
            return response as! [Person]
        } catch let error as NSError {
            // failure
            print(error)
            return [Person]()
        }
    }
    
    // Gets all.
    func getAll() -> [Person]{
        return get(withPredicate: NSPredicate(value:true))
    }

    // Updates a person
    func update(updatedPerson: Person){
        if let person = getById(updatedPerson.objectID){
            person.name = updatedPerson.name
            person.age = updatedPerson.age
            person.profile = updatedPerson.profile
        }
    }
    
    // Deletes a person
    func delete(id: NSManagedObjectID){
        if let personToDelete = getById(id){
            context.deleteObject(personToDelete)
        }
    }
    
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }

}





