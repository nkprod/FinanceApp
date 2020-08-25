//
//  MyCell.swift
//  MyMovieApp
//
//  Created by Sheryl Evangelene Pulikandala on 8/14/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var ImageTitile: UILabel!
    
    @IBOutlet weak var Overview: UILabel!
    
    @IBOutlet weak var Populatity: UILabel!
    
    @IBOutlet weak var Rating: UILabel!
    
    @IBOutlet weak var voteCount: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
