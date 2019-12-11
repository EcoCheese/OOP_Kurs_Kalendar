//
//  CoreDataManager.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 12/11/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
     
     init() {
            _ = persistentContainer
        }
        
        
        // MARK: - Core Data stack

        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Greensens")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
            return container
        }()
        
        
        // MARK: - Core Data Saving support

        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
        
        // MARK: - Fetch & Delete
        
        func fetchOne<T: NSManagedObject>(predicate: NSPredicate? = nil) -> T? {
            let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = predicate
            do {
                let models = try persistentContainer.viewContext.fetch(fetchRequest)
                return models.first
            } catch {
                preconditionFailure("Can't fetch models")
            }
        }
        
        func fetchAll<T: NSManagedObject>(predicate: NSPredicate? = nil) -> [T] {
            let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
            fetchRequest.predicate = predicate
            do {
                let models = try persistentContainer.viewContext.fetch(fetchRequest)
                return models
            } catch {
                preconditionFailure("Can't fetch models")
            }
        }
        
        func delete<T: NSManagedObject>(model: T) {
            persistentContainer.viewContext.delete(model)
        }
        
    }
