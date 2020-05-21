//
//  LanguageListTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 01/04/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class LanguageListTableViewCell: UITableViewCell {

    @IBOutlet weak var languageList: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setLanguage(text: String) {
        languageList.text = text
    }
    
}
