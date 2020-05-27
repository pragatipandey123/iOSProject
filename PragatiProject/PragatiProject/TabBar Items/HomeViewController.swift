//
//  HomeViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 14/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
  
    @IBOutlet weak var movieTableView: UITableView!
    
    var moviename = [nil, "Popular", "Best Drama", "Science Fiction", "Kids", "Comedy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
       

    let nib1 = UINib(nibName: "MovieSectionTableViewCell", bundle: nil)
    movieTableView.register(nib1, forCellReuseIdentifier: "movieCell")
        let nib2 = UINib(nibName: "SliderTableViewCell", bundle: nil)
        movieTableView.register(nib2, forCellReuseIdentifier: "slider")
    
    }
    
    
    //MARK: TableViewDelegates and DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell2 = movieTableView.dequeueReusableCell(withIdentifier: "slider", for: indexPath) as! SliderTableViewCell
            cell2.view = self
            return cell2
        }
         
        else {
            let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieSectionTableViewCell
            cell.view = self
            return cell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviename.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviename[section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
                   return 280
               }
               
               return 210
           }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              if let cell = cell as? MovieSectionTableViewCell{
                  
                cell.movieCollectionView.tag = indexPath.section
                cell.movieCollectionView.reloadData()
              }
          }
    }
    


        
    

    



