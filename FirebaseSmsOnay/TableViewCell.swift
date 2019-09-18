//
//  TableViewCell.swift
//  MarketApi
//
//  Created by imac1 on 5.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Ordercode: UILabel!
    @IBOutlet weak var Orderdate: UILabel!
    @IBOutlet weak var OrderStatus: UILabel!
    @IBOutlet weak var OrderWebSite: UILabel!
    
    
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
