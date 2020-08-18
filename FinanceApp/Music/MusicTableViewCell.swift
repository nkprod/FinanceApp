//
//  MusicTableViewCell.swift
//  Spotify_Embeded
//
//  Created by Chen Chen on 8/16/20.
//  Copyright © 2020 chen chen. All rights reserved.
//

import UIKit



class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var Artist: UILabel!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var Album: UILabel!
    var id: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Artist.accessibilityIdentifier = "artlabel"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
