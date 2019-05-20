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
    var expiryFetchedResultsController: NSFetchedResultsController<Expiry>?
    
    
    // Initialize the database
    override init() {
        persistantContainer = NSPersistentContainer(name: "ShoppingList")
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
    
    func addExpiry(name: String, date: Date) -> Expiry {
        let expiry = NSEntityDescription.insertNewObject(forEntityName: "Expiry", into: persistantContainer.viewContext) as! Expiry
        expiry.name = name
        expiry.date = date as NSDate
        saveContext()
        return expiry
    }
    
    func deleteExpiry(item: Expiry) {
        persistantContainer.viewContext.delete(item)
        saveContext()
    }
    

    
    // Add the given listener to the list of listeners
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == ListenerType.item {
            listener.onListChange(change: DatabaseChange.add, items: fetchItems())
        }
        if listener.listenerType == ListenerType.expiry {
            listener.onExpiryChange(change: DatabaseChange.add, items: fetchExpiry())
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
            let itemSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [itemSortDescriptor]
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
    
    // Fetch the tasks from core data database
    func fetchExpiry() -> [Expiry] {
        if expiryFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Expiry> = Expiry.fetchRequest()
            let expirySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [expirySortDescriptor]
            expiryFetchedResultsController = NSFetchedResultsController<Expiry>(fetchRequest: fetchRequest, managedObjectContext: persistantContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            expiryFetchedResultsController?.delegate = self
            
            do {
                try expiryFetchedResultsController?.performFetch()
            } catch {
                print("Fetch request failed: \(error)")
            }
        }
        var expiry = [Expiry]()
        if expiryFetchedResultsController?.fetchedObjects != nil {
            expiry = (expiryFetchedResultsController?.fetchedObjects)!
        }
        return expiry
    }
    
    
    // MARK: -Fetched Results Controller Delegate
    
    // Notifies listeners with changes
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == itemFetchedResultsController {
            listeners.invoke { (listener) in
                if listener.listenerType == ListenerType.item {
                    listener.onListChange(change: DatabaseChange.add, items:fetchItems())
                }
                if listener.listenerType == ListenerType.expiry {
                    listener.onExpiryChange(change: DatabaseChange.add, items: fetchExpiry())
                }
            }
        }
    }
}

