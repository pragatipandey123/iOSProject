//
//  DetailsCollectionViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 26/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var suggestedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        suggestedImage.layer.cornerRadius = 5
        suggestedImage.contentMode = .scaleToFill
    }

}
