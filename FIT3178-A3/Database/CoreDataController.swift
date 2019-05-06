//
//  CoreDataController.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 06/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistantContainer: NSPersistentContainer
    
    // Results
    var itemFetchedResultsController: NSFetchedResultsController<Item>?
    
    
    // Initialize the database
    override init() {
        persistantContainer = NSPersistentContainer(name: "Item")
        persistantContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        super.init()
    }
    
    // To make any changes persistent
    func saveContext() {
        if persistantContainer.viewContext.hasChanges {
            do {
                try persistantContainer.viewContext.save()
            } catch {
                fatalError("Failed to save data to core data: \(error)")
            }
        }
    }
    
    func addItem(name: String) -> Item {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: persistantContainer.viewContext) as! Item
        item.name = name
        saveContext()
        return item
    }
    
    // Delete task from database
    func deleteItem(item: Item) {
        persistantContainer.viewContext.delete(item)
        saveContext()
    }
    
    // Add the given listener to the list of listeners
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == ListenerType.item {
            listener.onListChange(change: DatabaseChange.add, items: fetchItems())
        }
    }
    
    // Remove the given listener from the list of listeners
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    // Fetch the tasks from core data database
    func fetchItems() -> [Item] {
        if itemFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            itemFetchedResultsController = NSFetchedResultsController<Item>(fetchRequest: fetchRequest, managedObjectContext: persistantContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            itemFetchedResultsController?.delegate = self
            
            do {
                try itemFetchedResultsController?.performFetch()
            } catch {
                print("Fetch request failed: \(error)")
            }
        }
        var items = [Item]()
        if itemFetchedResultsController?.fetchedObjects != nil {
            items = (itemFetchedResultsController?.fetchedObjects)!
        }
        return items
    }
    
    // MARK: -Fetched Results Controller Delegate
    
    // Notifies listeners with changes
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == itemFetchedResultsController {
            listeners.invoke { (listener) in
                if listener.listenerType == ListenerType.item {
                    listener.onListChange(change: DatabaseChange.add, items:fetchItems())
                }
            }
        }
    }
}

