//
//  AddItemDelegate.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 06/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

protocol AddItemDelegate: AnyObject {
    func addItem(newItem: ShoppingItem) -> Bool
}
