//
//  MovieDetailsViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 25/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var languageType: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var detailsCollection: UICollectionView!
    
    var newfav: [String] = []
    var views: UIViewController?
    var favListArray: [[String]] = []
    var counter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getDetails()
         views = self
         detailsCollection.delegate = self
         detailsCollection.dataSource = self
        
        let nib = UINib(nibName: "DetailsCollectionViewCell", bundle: nil)
        detailsCollection.register(nib, forCellWithReuseIdentifier: "detailsCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //User default for saving the movie list
        if UserDefaults.standard.object(forKey: "count") != nil{
            counter = UserDefaults.standard.object(forKey: "count") as! Int
        }
        if UserDefaults.standard.object(forKey: "favList") != nil {
            favListArray = UserDefaults.standard.object(forKey: "favList") as! [[String]]
        }
        print(favListArray)
    }
    
    //To show the detailed view of movies
    func getDetails() {
     
    if MovieSectionTableViewCell.type == 1 {
   newfav.append(MovieSectionTableViewCell.otherMovies?.poster_path ?? "")
            
       let url = URL(string: "https://image.tmdb.org/t/p/w500\(MovieSectionTableViewCell.otherMovies?.poster_path! ?? "")")
        let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        guard let response = data else {return}
                
        let finalImage = UIImage(data: response)
        DispatchQueue.main.async {
            self.movieImage.image = finalImage
            self.movieImage.contentMode = .scaleToFill
                }
            }
            dataFetch.resume()
            
    newfav.append(MovieSectionTableViewCell.otherMovies?.title ?? "")
            
            movieName.text = MovieSectionTableViewCell.otherMovies?.title
            movieDescription.text = MovieSectionTableViewCell.otherMovies?.overview
            
            ratings.text = String(describing:(MovieSectionTableViewCell.otherMovies?.popularity)!)
            year.text = String((MovieSectionTableViewCell.otherMovies?.release_date)?.prefix(4) ?? "")
            if(MovieSectionTableViewCell.otherMovies?.original_language == "en")
                      {
                          languageType.text = "English"
                      }
                      else
                      {
                          languageType.text = "Others"
                      }
                  }
        else {
            newfav.append(SliderTableViewCell.trending?.poster_path ?? "")
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(SliderTableViewCell.trending?.poster_path ?? "")")!
               let dataFetch = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let response = data else {return}
                
                let finalImage = UIImage(data: response)
                 DispatchQueue.main.async {
                    self.movieImage.image = finalImage
                    self.movieImage.contentMode = .scaleToFill
                }
            }
                dataFetch.resume()
    if SliderTableViewCell.trending?.media_type == "tv"{
                
    //appending the data in newfav to show in favourite table view
        newfav.append(SliderTableViewCell.trending?.name ?? "")
                
        movieName.text = SliderTableViewCell.trending?.name
        year.text = String((SliderTableViewCell.trending?.first_air_date)?.prefix(4) ?? "")
        }
        
        else {
    //appending the data in newfav to show in favourite table view
        newfav.append(SliderTableViewCell.trending?.title ?? "")
                
        movieName.text = SliderTableViewCell.trending?.title
        year.text = String((SliderTableViewCell.trending?.release_date)?.prefix(4) ?? "")
        }
           
        movieDescription.text = SliderTableViewCell.trending?.overview
        ratings.text = String(describing:(SliderTableViewCell.trending?.popularity)!)
            
        if(SliderTableViewCell.trending?.original_language == "en")
         {
            languageType.text = "English"
            }
        else {
            languageType.text = "Others"
         }
        }
        
        if favListArray.contains(newfav) {
        favouriteButton.setImage(UIImage(named: "FilledHeart.png"), for: .normal)
         }
            
        else{
            favouriteButton.setImage(UIImage(named: "EmptyHeart.png"), for: .normal)
            }
            favouriteButton.contentMode = .scaleAspectFit
        }
    
    //MARK: CollectionView Delegates and DataSources
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if MovieSectionTableViewCell.type == 1 {
            return MovieSectionTableViewCell.finalSections?.results?.count ?? 0
            }
            else {
                return SliderTableViewCell.final?.results.count ?? 0
            }
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if MovieSectionTableViewCell.type == 1 {
          let cell = detailsCollection.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCollectionViewCell
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(MovieSectionTableViewCell.finalSections?.results?[indexPath.row].poster_path ?? "")")!
        
         let dataFetch = URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let response = data else {return}

         let finalImage = UIImage(data: response)
                DispatchQueue.main.async {
                cell.suggestedImage.image = finalImage
        }
    }
            dataFetch.resume()
            return cell
        }
        else {
            let cell = detailsCollection.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCollectionViewCell
                    
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(SliderTableViewCell.final?.results[indexPath.row].poster_path ?? "")")!
                
            let dataFetch = URLSession.shared.dataTask(with: url) { (data, response, error) in
                 guard let response = data else {return}

            let finalImage = UIImage(data: response)
                        DispatchQueue.main.async {
                        cell.suggestedImage.image = finalImage
                }
            }
                    dataFetch.resume()
                    return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if MovieSectionTableViewCell.type == 1 {
            MovieSectionTableViewCell.otherMovies = MovieSectionTableViewCell.finalSections?.results?[indexPath.row]
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
            views?.navigationController!.pushViewController(vc, animated: true)
        }
        else{
            SliderTableViewCell.trending = SliderTableViewCell.final?.results[indexPath.row]
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
            views?.navigationController!.pushViewController(vc, animated: true)
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: 200, height: 130)
        }
    
      //Favourite button action
    @IBAction func favouriteTapped(_ sender: UIButton) {

        if favListArray.contains(newfav) {
        favListArray.remove(at: favListArray.firstIndex(of: newfav)!)
        counter = counter - 1
         }

        else{
              counter = counter + 1
              favListArray.append(newfav)
            }
        
        //saving the values with specific key
        UserDefaults.standard.set(counter, forKey: "count")
        UserDefaults.standard.set(favListArray, forKey: "favList")

        if favListArray.contains(newfav) {
            favouriteButton.setImage(UIImage(named: "FilledHeart.png"), for: .normal)
            }
            
            else{
                 favouriteButton.setImage(UIImage(named: "EmptyHeart.png"), for: .normal)
               }
        
               favouriteButton.contentMode = .scaleAspectFit
               print(favListArray)
           }
    }


   


