//
//  CountryAndLanguageViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 01/04/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class CountryAndLanguageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var countryListTableView: UITableView!
    public static var select = ""
    
    let language = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
    var countriesData = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
       
    override func viewDidLoad() {
        super.viewDidLoad()
 
        countryListTableView.delegate = self
        countryListTableView.dataSource = self

        let nib1 = UINib.init(nibName: "CountryListTableViewCell", bundle: nil)
        countryListTableView.register(nib1, forCellReuseIdentifier: "countryListCell")
        let nib2 = UINib.init(nibName: "LanguageListTableViewCell", bundle: nil)
               countryListTableView.register(nib2, forCellReuseIdentifier: "languageList")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if CountryAndLanguageViewController.select == "Country" {
                       let cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryListTableViewCell
                                      
                        cell.setCountry(text: countriesData[indexPath.row])
            return cell
                      
            }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "languageList", for: indexPath) as! LanguageListTableViewCell
            
            cell.setLanguage(text: language[indexPath.row])
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        countryListTableView.deselectRow(at: indexPath, animated: true)
         
        if CountryAndLanguageViewController.select == "Country" {
            AccountViewController.finalCountry = countriesData[indexPath.row]
            
        }
            
        else {
           
            AccountViewController.finalLanguageName = language[indexPath.row]
        }
        self.navigationController?.popViewController(animated: true)
       
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 60
        }
        
    }

                       
        
                       
                  
    

    

    

 
    
   
    



   


