//
//  IngredientTableViewCell.swift
//  FIT3178-A3
//
//  Created by Chuan Yeamern on 19/06/2019.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import Foundation

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
