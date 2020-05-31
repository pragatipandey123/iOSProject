//
//  TextColorViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 30/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class TextColorViewController: UIViewController {

    @IBOutlet weak var textColorView: UIView!
     let textColorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 400))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textColorView.addSubview(textColorPicker)
        textColorPicker.setViewColor(UIColor.red)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func textColorSelected(_ sender: Any) {
        ThemeViewController.textColor = textColorPicker.color
        self.navigationController?.popViewController(animated: true)
    }
    
}
