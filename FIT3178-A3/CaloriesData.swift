//
//  CaloriesData.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 8/6/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
class CaloriesData: NSObject, Decodable {
    var calories: String?
    
    private enum CodingKeys: String, CodingKey {
        case calories
    }
    
}
