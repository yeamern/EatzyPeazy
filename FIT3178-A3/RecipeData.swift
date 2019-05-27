//
//  RecipeData.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 27/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
class RecipeData: NSObject, Decodable {
    var id: Int?
    var title: String?
    
    private enum RecipeKeys: String, CodingKey {
        case id
        case title
    }
    
    required init(from decoder: Decoder) throws {
        let recipeContainer = try decoder.container(keyedBy: RecipeKeys.self)
        self.id = try recipeContainer.decode(Int.self, forKey: .id)
        self.title = try recipeContainer.decode(String.self, forKey: .title)
    }
}
