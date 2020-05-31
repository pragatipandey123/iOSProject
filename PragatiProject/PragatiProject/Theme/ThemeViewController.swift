//
//  ThemeViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 30/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import iOSDropDown
import SwiftHSVColorPicker

class ThemeViewController: UIViewController{

    @IBOutlet weak var dropDown: DropDown!
    
    var font: String?
    static var backgroundColour: UIColor?
    static var textColor: UIColor?
    static var buttonColour: UIColor?
    
    
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
    
    @IBAction func selectBackgroundColorTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BackgroundColorViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectTextColor(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TextColorViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonBackgroundTapped(_ sender: Any) {
       let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ButtonBackgroundViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func themeTapped(_ sender: Any) {
        let sample = UILabel.appearance()
        let viewColor = UIView.appearance()
        let button = UIButton.appearance()
        sample.font = UIFont(name: self.font ?? "San Fransico", size: 18)
        
    viewColor.backgroundColor = ThemeViewController.backgroundColour ?? UIColor.white
        
    sample.textColor = ThemeViewController.textColor ?? UIColor.black
        button.backgroundColor = ThemeViewController.buttonColour ?? UIColor.systemPink
    button.setTitleColor(ThemeViewController.textColor, for: .normal)
    button.setTitleColor(ThemeViewController.backgroundColour, for: .highlighted)

    self.navigationController?.popViewController(animated: true) 
    }
}
