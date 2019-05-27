//
//  UnitsData.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 27/05/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

class UnitsData: NSObject, Decodable {
    var quantity: Decimal?
    var source: String?
    var target: String?
    
    private enum RootKeys: String, CodingKey {
    	case root = "UCUMWebServiceResponse"
    }
    
    private enum ResponseKeys: String, CodingKey {
        case response = "Response"
    }
    
    private enum UnitKeys: String, CodingKey {
        case quantity = "SourceQuantity"
        case sourceUnit = "SourceUnit"
        case targetUnit = "TargetUnit"
        case result = "ResultQuantity"
    }
    
    required init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        let responseContainer = try rootContainer.nestedContainer(keyedBy: ResponseKeys.self, forKey: .root)
        let unitContainer = try responseContainer.nestedContainer(keyedBy: UnitKeys.self, forKey: .response)
        
        self.quantity = try unitContainer.decode(Decimal.self, forKey: .quantity)
        self.source = try unitContainer.decode(String.self, forKey: .sourceUnit)
        self.target = try unitContainer.decode(String.self, forKey: .targetUnit)
    }
}
