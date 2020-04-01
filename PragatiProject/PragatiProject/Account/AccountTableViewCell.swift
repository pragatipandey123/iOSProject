//
//  AccountTableViewCell.swift
//  PragatiProjectUITests
//
//  Created by Pragati Pandey on 31/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCell: UILabel!    
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setLabel(text: String) {
        
        labelCell.text = text
    }
    
    //function of set image to cell image
    func setImage(image: UIImage) {
        
        imageCell.image = image
    }
    
}
