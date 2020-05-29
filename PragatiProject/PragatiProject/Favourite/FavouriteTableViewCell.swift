//
//  FavouriteTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 28/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favouriteMovieImage: UIImageView!
    @IBOutlet weak var favouriteMovieName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
