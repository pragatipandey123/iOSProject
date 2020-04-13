//
//  CountryTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 31/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCountryCell: UIImageView!
    @IBOutlet weak var labelCountryCell: UILabel!
    @IBOutlet weak var finalCountryLabel: UILabel!
    @IBOutlet weak var finalFlagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImageCountry(image: UIImage) {
        imageCountryCell.image = image
    }
    func setLabelCountry(text: String) {
        labelCountryCell.text = text
    }
    func setFinalCountry(text: String) {
        finalCountryLabel.text = text
    }
    func setCountryFlagImageView(image: UIImage) {
           finalFlagImage.image = image
       }
    
    
    
}
