//
//  AccountViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 26/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountTableView: UITableView!
   
   
    public static var finalCountry : String = "IND"
    public static var finalLanguageName : String = "ENG"

    
    let cellLabelArray = [ ["Track Order", "Size Chart", "Notifications", "Store Location"], ["Country", "Language", "About Us", "FAQ", "Shipping & Returns"] ]
    let cellImageArray = [ [#imageLiteral(resourceName: "TrackOrder"), #imageLiteral(resourceName: "SizeChart"), #imageLiteral(resourceName: "Notifications"), #imageLiteral(resourceName: "StoreLocator")], [ #imageLiteral(resourceName: "Country"), #imageLiteral(resourceName: "Language"), #imageLiteral(resourceName: "AboutUs"), #imageLiteral(resourceName: "FAQ"), #imageLiteral(resourceName: "ShippingAndReturn")] ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountTableView.delegate = self
        accountTableView.dataSource = self
        accountTableView.reloadData()
        
        roundedShape()
    
        let nib1 = UINib(nibName: "AccountTableViewCell", bundle: nil)
        accountTableView.register(nib1, forCellReuseIdentifier: "accountPageCell")
        let nib2 = UINib(nibName: "CountryTableViewCell", bundle: nil)
        accountTableView.register(nib2, forCellReuseIdentifier: "countryCell")
        let nib3 = UINib(nibName: "LanguageTableViewCell", bundle: nil)
        accountTableView.register(nib3, forCellReuseIdentifier: "languageCell")
        
        
        //to make the imageView clickable
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(clicking))
        accountImage.isUserInteractionEnabled = true
        accountImage.addGestureRecognizer(singleTap)
    }
    
    // to make the account image rounded shape
    func roundedShape() {
        accountImage.layer.cornerRadius = accountImage.frame.height/2
        accountImage.contentMode = .scaleToFill
        accountImage.clipsToBounds = true
    }

   
    // selector function of an ImageView
    @objc func clicking() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                   self.camera()
               }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert: UIAlertAction!) -> Void in self.Gallery() }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        return
    }
    
    
    //MARK: Camera Action
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
      
    //MARK: Gallery Action
        func Gallery() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .photoLibrary
                myPickerController.allowsEditing = true
                self.present(myPickerController, animated: true, completion: nil)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
        
        //MARK: Image Picker Controller Delegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            {
                let pickedImage = info[.editedImage]
                self.accountImage.image = pickedImage as? UIImage
            }
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabelArray[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if indexPath.section == 1 && indexPath.row == 0 {
               let cell = accountTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
            
               cell.setImageCountry(image: cellImageArray[1][0])
               cell.setLabelCountry(text: cellLabelArray[1][0])
              cell.setFinalCountry(text: AccountViewController.finalCountry)
            print(AccountViewController.finalCountry)
               return cell
           }
           
           else if indexPath.section == 1 && indexPath.row == 1 {
            
               let cell = accountTableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
            
               cell.setImageLanguage(image: cellImageArray[1][1])
               cell.setLabelLanguage(text: cellLabelArray[1][1])
            cell.setFinalLanguage(text: AccountViewController.finalLanguageName)
             print(AccountViewController.finalLanguageName)
               return cell
           }
           
           else {
                      
                   let cell = accountTableView.dequeueReusableCell(withIdentifier: "accountPageCell", for: indexPath) as! AccountTableViewCell
                  cell.setLabel(text:cellLabelArray[indexPath.section][indexPath.row])
                  cell.setImage(image: cellImageArray[indexPath.section][indexPath.row])
                 
               return cell
           }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        accountTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {

            CountryAndLanguageViewController.select = "Country"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CountryAndLanguageViewController")
                self.navigationController?.pushViewController(vc, animated: true)

            }

        else if indexPath.section == 1 && indexPath.row == 1 {
             
                CountryAndLanguageViewController.select = "Language"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CountryAndLanguageViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
   
    
    


