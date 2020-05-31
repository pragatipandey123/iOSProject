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
    // The list of array to display. Can be changed dynamically
        dropDown.optionArray = UIFont.familyNames
    // This the Closure returns Selected Index and String
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
    
    //changing the font family of an app
        sample.font = UIFont(name: self.font ?? "San Fransico", size: 18)
    //changing background color of all the views
    viewColor.backgroundColor = ThemeViewController.backgroundColour ?? UIColor.white
    
     //changing text color of all the labels
    sample.textColor = ThemeViewController.textColor ?? UIColor.black
    
    //changing the button background color
    button.backgroundColor = ThemeViewController.buttonColour ?? UIColor.systemPink
    
    //changing the button text color in normal state
    button.setTitleColor(ThemeViewController.textColor, for: .normal)
    
    // //changing the button text color in highlited state
    button.setTitleColor(ThemeViewController.backgroundColour, for: .highlighted)

    self.navigationController?.popViewController(animated: true) 
    }
}
