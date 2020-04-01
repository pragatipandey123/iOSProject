//
//  LanguageTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 31/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageLanguageCell: UIImageView!
    @IBOutlet weak var labelLanguageCell: UILabel!

    @IBOutlet weak var finalLanguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImageLanguage(image: UIImage) {
           imageLanguageCell.image = image
       }
       func setLabelLanguage(text: String) {
           labelLanguageCell.text = text
       }
    func setFinalLanguage(text: String) {
        finalLanguage.text = text
    }
}
