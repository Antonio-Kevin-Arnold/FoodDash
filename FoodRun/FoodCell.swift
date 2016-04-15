//
//  FoodCell.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/12/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
