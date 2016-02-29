//
//  CelllTableTableViewCell.swift
//  InstaGram
//
//  Created by saritha on 2/27/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit

class CelllTableTableViewCell: UITableViewCell {

    @IBOutlet var CaptionForText: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
