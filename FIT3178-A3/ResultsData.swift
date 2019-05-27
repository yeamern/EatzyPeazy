//
//  ResultsData.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 27/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation
class ResultsData: NSObject, Decodable {
    var results: [RecipeData]?
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
}
