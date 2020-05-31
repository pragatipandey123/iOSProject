//
//  BackgroundColorViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 30/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker


class BackgroundColorViewController: UIViewController {

    @IBOutlet weak var bgColorView: UIView!
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 400))
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.bgColorView.addSubview(colorPicker)
       colorPicker.setViewColor(UIColor.red)
    }
    
    @IBAction func selectedButtonTapped(_ sender: Any) {
        ThemeViewController.backgroundColour = colorPicker.color
        print(colorPicker.color!)
    self.navigationController?.popViewController(animated: true)
    }
    
}
