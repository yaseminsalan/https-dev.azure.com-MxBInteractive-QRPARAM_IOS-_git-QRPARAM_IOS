//
//  QrOrderViewControllerTableViewCell.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 22.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class QrOrderViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var label_totalprice: UILabel!
    @IBOutlet weak var label_paytype: UILabel!
    @IBOutlet weak var label_unitprice: UILabel!
    @IBOutlet weak var label_ordername: UILabel!
    @IBOutlet weak var label_productcode: UILabel!
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
