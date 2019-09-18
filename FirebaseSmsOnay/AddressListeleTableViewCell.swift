//
//  AddressListeleTableViewCell.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/29/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class AddressListeleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var adress_lbl: UILabel!
    
   
    @IBAction func PriorityStatus(_ sender: UISwitch) {
        
        
    }
    @IBOutlet var priority: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
