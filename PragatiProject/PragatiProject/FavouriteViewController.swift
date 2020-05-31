//
//  FavouriteViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 28/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favouriteTableView: UITableView!

    var favListArray : [[String]] = []
    var Counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self

        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        favouriteTableView.register(nib, forCellReuseIdentifier: "favouriteCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favListArray = UserDefaults.standard.object(forKey: "favList") as! [[String]]
        Counter = UserDefaults.standard.object(forKey: "count") as! Int
        self.favouriteTableView.reloadData()
        print("1-\(favListArray)")
    }

//MARK: TableView Delegates and DataSources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteTableViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(favListArray[indexPath.row][0])")!
            let dataFetch = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = data else {return}

            let finalImage = UIImage(data: response)
                DispatchQueue.main.async {
                cell.favouriteMovieImage.image = finalImage
                cell.favouriteMovieImage.contentMode = .scaleToFill
                    }
        }
        dataFetch.resume()
     cell.favouriteMovieName.text = favListArray[indexPath.row][1]
        return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 100
        
    }
}
