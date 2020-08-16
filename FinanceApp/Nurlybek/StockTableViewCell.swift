//
//  StockTableViewCell.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/14/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints


class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


