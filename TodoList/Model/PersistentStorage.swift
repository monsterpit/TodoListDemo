//
//  PersistentStorage.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import Foundation
import CoreData

final class PersistentStorage{
    
    private init(){}
    static let shared = PersistentStorage()
    lazy var  context = persistentContainer.viewContext
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TodoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    func getAllItems() -> [TodoListItem]{
        do {
            return try context.fetch(TodoListItem.fetchRequest())
        } catch let error {
            debugPrint(error)
            return []
        }
    }
    
    func getAllSearchedItems(searchText: String) -> [TodoListItem]{
        do {
            let predicate = NSPredicate(format: "createdAt contains %@", searchText)
            let request: NSFetchRequest = TodoListItem.fetchRequest()
            request.predicate = predicate
            return try context.fetch(request)
        } catch let error {
            debugPrint(error)
            return []
        }
    }
    
     func createItem(title: String,desc: String?,createdAt: String){
        let newItem = TodoListItem(context: context)
        newItem.title = title
        newItem.desc = desc
        newItem.createdAt = createdAt
        saveDB()
    }
    
     func deleteItem(item: TodoListItem){
        context.delete(item)
        saveDB()
    }
    
     func updateItem(item: TodoListItem,title: String,desc: String?){
        item.title = title
        item.desc = desc
        saveDB()
    }
    
    private func saveDB(){
        do {
            try context.save()
        } catch let error {
            debugPrint(error)
        }
    }
}
