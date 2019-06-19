//
//  UnitsData.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 27/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

class UnitsData: NSObject, Decodable {
    var valid: Bool?
    var result: String?
    var toType: String?
    var fromType: String?
    var fromValue: String?
    
    private enum CodingKeys: String, CodingKey {
        case valid
        case result
        case toType = "to-type"
        case fromType = "from-type"
        case fromValue = "from-value"
    }

}
