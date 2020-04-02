//
//  CountryListTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 01/04/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryListLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCountry(text: String) {
        countryListLabel.text = text
    }
    
    
}
