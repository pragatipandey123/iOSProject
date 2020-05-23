//
//  MovieCollectionViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 23/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var imageName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        wholeView.layer.cornerRadius = 5
        wholeView.clipsToBounds = true
       
        
    }

}
