//
//  OrderdetailTableViewCell.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/30/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class OrderdetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ordercode: UILabel!

    @IBOutlet weak var orderproductname: UILabel!
    

    @IBOutlet weak var orderunitprice: UILabel!
    
    @IBOutlet weak var orderpaymentmethod: UILabel!
    
    @IBOutlet weak var ordertotalprıce: UILabel!
  
    @IBOutlet weak var viewcell: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
