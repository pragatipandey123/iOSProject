//
//  ThemeViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 30/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import iOSDropDown

class ThemeViewController: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
    
    var font: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       fontStyle()
    }
    
    func fontStyle() {
        
        dropDown.optionArray = UIFont.familyNames
        dropDown.didSelect { (SelectedFont, Index, id) in
            self.font = SelectedFont
        }
    }

    @IBAction func themeTapped(_ sender: Any) {
        let sample = UILabel.appearance()
        let sampleButton = UIButton.appearance()
        sample.font = UIFont(name: self.font ?? "Times New Roman", size: 18)
        sampleButton.titleLabel?.font = UIFont(name: self.font ?? "Times New Roman", size: 18)
    self.navigationController?.popViewController(animated: true) 
    }
    

}
