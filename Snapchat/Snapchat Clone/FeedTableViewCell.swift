//
//  FeedTableViewCell.swift
//  Snapchat Clone
//
//  Created by Yi Cao on 10/19/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var readStatus: UIImageView!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var senderName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
