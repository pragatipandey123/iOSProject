//
//  ImageSliderCollectionViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 20/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class ImageSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageSliding: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageSliding.layer.cornerRadius = 10
        imageSliding.clipsToBounds = true
        
    }

}
