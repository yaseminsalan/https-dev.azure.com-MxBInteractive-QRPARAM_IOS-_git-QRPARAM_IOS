//
//  KrediKartiListeleTableViewCell.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 3/19/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class KrediKartiListeleTableViewCell: UITableViewCell {

    
    @IBOutlet var carttype: UILabel!
    
    @IBOutlet var cartno: UILabel!
    @IBOutlet var cartname: UILabel!
    @IBOutlet var viewcell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
