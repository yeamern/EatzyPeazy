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
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onListChange(change: DatabaseChange, items: [Item])
}

protocol DatabaseProtocol: AnyObject {
    func addItem(name: String) -> Item
    func deleteItem(item: Item)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
