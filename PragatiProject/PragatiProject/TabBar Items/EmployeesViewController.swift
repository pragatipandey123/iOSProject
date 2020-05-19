//
//  EmployeesViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 15/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit


class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.isHidden = false
        cardView.isHidden = true
        
    }
    
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            listView.isHidden = false
            cardView.isHidden = true
        }
        else {
            listView.isHidden = true
            cardView.isHidden = false
        }
    }
   
   


}
