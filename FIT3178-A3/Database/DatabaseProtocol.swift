//
//  DatabaseProtocol.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 06/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
}

enum ListenerType {
    case item
    case expiry
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onListChange(change: DatabaseChange, items: [Item])
    func onExpiryChange(change: DatabaseChange, items: [Expiry])
}

protocol DatabaseProtocol: AnyObject {
    func addItem(name: String) -> Item
    func deleteItem(item: Item)
    func addExpiry(name: String, date: Date) -> Expiry
    func deleteExpiry(item: Expiry)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
