//
//  ListTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 19/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(data: Employee?) {
        
        id.text = "ID: \(data?.id ?? "")"
        name.text = "Name: \(data?.employee_name ?? "")"
        
    }
    
}
