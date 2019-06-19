//
//  FoodData.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 18/06/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

class FoodData: NSObject, Decodable {
    var title: String?
    var nutrients: [NutrientsData]?
    
    private enum CodingKeys: String, CodingKey {
        case title = "text"
        case nutrients = "parsed"
    }
}
