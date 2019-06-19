//
//  NutrientsData.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 18/06/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
class NutrientsData: NSObject, Decodable {
    var calcium: Float?
    var carbs: Float?
    var cholesterol: Float?
    var fat: Float?
    var fiber: Float?
    var calories: Float?
    var protein: Float?
    var sugar: Float?
    
    private enum RootKeys: String, CodingKey {
        case food
    }
    
    private enum FoodKeys: String, CodingKey {
        case nutrients
    }
    
    private enum NutrientKeys: String, CodingKey {
        case calcium = "CA"
        case carbs = "CHOCDF"
        case cholesterol = "CHOLE"
        case fat = "FAT"
        case fiber = "FIBTG"
        case calories = "ENERC_KCAL"
        case protein = "PROCNT"
        case sugar = "SUGAR"
    }
    
    required init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        let foodContainer = try rootContainer.nestedContainer(keyedBy: FoodKeys.self, forKey: .food)
        let nutrientContainer = try foodContainer.nestedContainer(keyedBy: NutrientKeys.self, forKey: .nutrients)
        
        self.calcium = try? nutrientContainer.decode(Float.self, forKey: .calcium)
        self.carbs = try? nutrientContainer.decode(Float.self, forKey: .carbs)
        self.cholesterol = try? nutrientContainer.decode(Float.self, forKey: .cholesterol)
        self.fat = try? nutrientContainer.decode(Float.self, forKey: .fat)
        self.fiber = try? nutrientContainer.decode(Float.self, forKey: .fiber)
        self.calories = try? nutrientContainer.decode(Float.self, forKey: .calories)
        self.protein = try? nutrientContainer.decode(Float.self, forKey: .protein)
        self.sugar = try? nutrientContainer.decode(Float.self, forKey: .sugar)
    }
}
