//
//  GetRecipeData.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 8/6/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
class GetRecipeData: NSObject, Decodable {
    var image: URL?
    var title: String?
    var readyInMinutes: Int?
    var instructions: String?
    var extendedIngredients: [IngredientsData]?
    
    private enum RootKeys: String, CodingKey {
        case image
        case title
        case readyInMinutes
        case instructions
        case extendedIngredients
    }
    
    required init(from decoder: Decoder) throws {
        let recipeContainer = try decoder.container(keyedBy: RootKeys.self)
        self.image = try recipeContainer.decode(URL.self, forKey: .image)
        self.title = try recipeContainer.decode(String.self, forKey: .title)
        self.readyInMinutes = try recipeContainer.decode(Int.self, forKey: .readyInMinutes)
        self.instructions = try recipeContainer.decode(String.self, forKey: .instructions)
        self.extendedIngredients = try recipeContainer.decode([IngredientsData].self, forKey: .extendedIngredients)
        print(extendedIngredients)
    }
}
