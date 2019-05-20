//
//  ExpiryTableViewCell.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 20/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

import UIKit

class ExpiryTableViewCell: UITableViewCell {

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
