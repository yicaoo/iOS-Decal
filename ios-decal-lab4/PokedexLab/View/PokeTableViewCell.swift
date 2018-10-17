//
//  PokeTableViewCell.swift
//  PokedexLab
//
//  Created by Yi Cao on 10/16/18.
//  Copyright © 2018 iOS Decal. All rights reserved.
//

import UIKit

class PokeTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel! {
        didSet{
            Name.text = "Pikachu \n 225"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
