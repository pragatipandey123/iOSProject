//
//  ButtonBackgroundViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 31/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class ButtonBackgroundViewController: UIViewController {
    
    @IBOutlet weak var buttonColorView: UIView!
    
    let buttonColorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.buttonColorView.addSubview(buttonColorPicker)
        buttonColorPicker.setViewColor(UIColor.red)
    }
    
    @IBAction func buttonBackgroundTapped(_ sender: Any) {
    ThemeViewController.buttonColour = buttonColorPicker.color
        self.navigationController?.popViewController(animated: true)
    }
}
