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
     var flag = #imageLiteral(resourceName: "Country")
    
    //TO show all languages
    let language = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
    
    //To show all the countries
    var countriesData = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
     var countryCode = Locale.isoRegionCodes
       
    override func viewDidLoad() {
        super.viewDidLoad()
 
        countryListTableView.delegate = self
        countryListTableView.dataSource = self

        let nib1 = UINib.init(nibName: "CountryListTableViewCell", bundle: nil)
        countryListTableView.register(nib1, forCellReuseIdentifier: "countryListCell")
        let nib2 = UINib.init(nibName: "LanguageListTableViewCell", bundle: nil)
        countryListTableView.register(nib2, forCellReuseIdentifier: "languageList")
    }

    //MARK: TABLE VIEW DELEGATES AND DATA SOURCES
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

 if CountryAndLanguageViewController.select == "Country" {
    let cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryListTableViewCell
        cell.setCountry(text: countriesData[indexPath.row])
    
        // using API for flags
        if let url = URL(string: "https://www.countryflags.io/\(countryCode[indexPath.row])/shiny/64.png") {

         URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    //passing an image
                cell.setFlag(image: UIImage(data: data) ?? self.flag)
                cell.flagList.contentMode = .scaleAspectFill
                       }
                 }
               }.resume()
           }
            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "languageList", for: indexPath) as! LanguageListTableViewCell
            cell.setLanguage(text: language[indexPath.row])
            return cell
    }
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        countryListTableView.deselectRow(at: indexPath, animated: true)
        if CountryAndLanguageViewController.select == "Country" {
            let countryName = (countryCode[indexPath.row].uppercased())
        
            AccountViewController.finalCountry = countryName
        }
            
        else {
            let languageName = (language[indexPath.row].prefix(3).uppercased())
            AccountViewController.finalLanguageName = languageName
        }
        self.navigationController?.popViewController(animated: true)
    }
}
                       
        
                       
                  
    

    

    

 
    
   
    



   


