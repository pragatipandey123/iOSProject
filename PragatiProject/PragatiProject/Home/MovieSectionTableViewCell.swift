//
//  MovieSectionTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 23/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

class MovieSectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
       
    @IBOutlet weak var movieCollectionView: UICollectionView!
        
    var popularityModel: OtherMovies?
    var bestDramaModel: OtherMovies?
    var scienceFictionModel: OtherMovies?
    var kidsModel: OtherMovies?
    var comedyModel: OtherMovies?
    var view: UIViewController?
    
    static var otherMovies : Details?//to pass the details of selected movie on MovieDetailViewController
    static var type = -1 // to diffrentiate which type of movie details has to be shown
    static var finalSections: OtherMovies?//to store the whole model so that the on MovieDetailViewController movies can be shown in collection view of users also liked this
      
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
            
            getThePopularity()
            getBestDrama()
            getScienceFictionData()
            getKidsData()
            getComdeyMoviesData()
           
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            movieCollectionView.register(nib, forCellWithReuseIdentifier: "movieCollection")
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    //MARK: PopularityData
        func getThePopularity() {
        AF.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
                .responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                        print(error)
                case .success(let data):
                do {
                    let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(OtherMovies.self, from: data)
                    self?.popularityModel = result
                        print(result)
                    } catch { print(error) }
                }
                  self?.movieCollectionView.reloadData()
            }
        }
    
    //MARK: BestDrama Data
    func getBestDrama() {
       AF.request("https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
               .responseData { [weak self] response in
           switch response.result {
               case .failure(let error):
                       print(error)
               case .success(let data):
                   do {
                       let decoder = JSONDecoder()
                           decoder.keyDecodingStrategy = .useDefaultKeys
                       let result = try decoder.decode(OtherMovies.self, from: data)
                           self?.bestDramaModel = result
                           print(result)
                       } catch { print(error) }
                   }
                   self?.movieCollectionView.reloadData()
           }
       }
    
    //MARK: ScienceFiction Data
  func getScienceFictionData() {
        AF.request("http://api.themoviedb.org/3/discover/movie?certification_country=US&certification=R&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
                .responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                        print(error)
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                        let result = try decoder.decode(OtherMovies.self, from: data)
                            self?.scienceFictionModel = result
                            print(result)
                        } catch { print(error) }
                    }
                    self?.movieCollectionView.reloadData()
            }
        }
    
    //MARK: Kids Data
    func getKidsData() {
    AF.request("https://api.themoviedb.org/3/discover/movie?certification_country=US&certification=R&sort_by=revenue.desc&with_cast=3896&api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData { [weak self] response in
        switch response.result {
            case .failure(let error):
                    print(error)
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(OtherMovies.self, from: data)
                        self?.kidsModel = result
                        print(result)
                    } catch { print(error) }
                }
                self?.movieCollectionView.reloadData()
        }
    }
    
    func getComdeyMoviesData() {
    AF.request("https://api.themoviedb.org/3/discover/movie?with_genres=18&primary_release_year=2014&api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData { [weak self] response in
        switch response.result {
            case .failure(let error):
                    print(error)
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(OtherMovies.self, from: data)
                        self?.comedyModel = result
                        print(result)
                    } catch { print(error) }
                }
                self?.movieCollectionView.reloadData()
        }
    }
    
        
    //MARK: CollectionView Delegates and DataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularityModel?.results?.count ?? 0
     }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 //here tag works as indexPath.section to show different movies in different section
        //Popular Data
        if collectionView.tag == 1 {
            let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
            cell.imageName.text = ( popularityModel?.results?[indexPath.row].title)
            cell.movieType.text = "Action"
            cell.rating.text = String(describing:(popularityModel?.results?[indexPath.row].vote_average)!)

            let url = URL(string: "https://image.tmdb.org/t/p/w500\(popularityModel?.results?[indexPath.row].poster_path ?? "")")
               let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let response = data else {return}

                let finalImage = UIImage(data: response)
                 DispatchQueue.main.async {
                    cell.imageView.image = finalImage
                }
            }
                dataFetch.resume()

                  return cell
            }
            //Best Drama Data
             else if collectionView.tag == 2 {
                 let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
                
                cell.imageName.text = ( bestDramaModel?.results?[indexPath.row].title)
                cell.movieType.text = "Dramatic"
            cell.rating.text = String(describing:(bestDramaModel?.results?[indexPath.row].vote_average) ?? 8.5)

                let url = URL(string: "https://image.tmdb.org/t/p/w500\(bestDramaModel?.results?[indexPath.row].poster_path ?? "")")
                   let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    guard let response = data else {return}

                    let finalImage = UIImage(data: response)
                     DispatchQueue.main.async {
                        cell.imageView.image = finalImage
                    }
                }
                    dataFetch.resume()

                      return cell
            }
            //Science Fiction Data
               else if collectionView.tag == 3 {
                let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
                              
                cell.imageName.text = ( scienceFictionModel?.results?[indexPath.row].title)
                cell.movieType.text = "Thriller"
            cell.rating.text = String(describing:(scienceFictionModel?.results?[indexPath.row].vote_average) ?? 9.3)

                let url = URL(string: "https://image.tmdb.org/t/p/w500\(scienceFictionModel?.results?[indexPath.row].poster_path ?? "")")
                let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let response = data else {return}

                let finalImage = UIImage(data: response)
                DispatchQueue.main.async {
                cell.imageView.image = finalImage
                }
                 }
                    dataFetch.resume()

                return cell
            }
            //Kids Data
            else if collectionView.tag == 4 {
            let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
                                            
            cell.imageName.text = ( kidsModel?.results?[indexPath.row].title)
            cell.movieType.text = "Entertainment"
            cell.rating.text = String(describing:(kidsModel?.results?[indexPath.row].vote_average) ?? 8.0)

                let url = URL(string: "https://image.tmdb.org/t/p/w500\(kidsModel?.results?[indexPath.row].poster_path ?? "")")
            let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let response = data else {return}

            let finalImage = UIImage(data: response)
            DispatchQueue.main.async {
            cell.imageView.image = finalImage
                }
            }
            dataFetch.resume()

            return cell
            }
            // Comedy Data
        else if collectionView.tag == 5 {
            let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
                                                                
            cell.imageName.text = ( comedyModel?.results?[indexPath.row].title)
            cell.movieType.text = "Comedy"
            cell.rating.text = String(describing:(comedyModel?.results?[indexPath.row].vote_average) ?? 9.0)

            let url = URL(string: "https://image.tmdb.org/t/p/w500\(comedyModel?.results?[indexPath.row].poster_path ?? "")")
            let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let response = data else {return}

         let finalImage = UIImage(data: response)
                    DispatchQueue.main.async {
                    cell.imageView.image = finalImage
                                    }
                    }
                dataFetch.resume()

                return cell
            }
            
        else {
                 let cell  = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
                return cell
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            
           MovieSectionTableViewCell.type = 1
           MovieSectionTableViewCell.finalSections = popularityModel
            MovieSectionTableViewCell.otherMovies = popularityModel?.results?[indexPath.row]
           

        case 2:
            MovieSectionTableViewCell.type = 1
            MovieSectionTableViewCell.finalSections = bestDramaModel
        MovieSectionTableViewCell.otherMovies = bestDramaModel?.results?[indexPath.row]
        
            
        case 3:
            MovieSectionTableViewCell.type = 1
            MovieSectionTableViewCell.finalSections = scienceFictionModel
            MovieSectionTableViewCell.otherMovies = scienceFictionModel?.results?[indexPath.row]
            
        case 4:
            MovieSectionTableViewCell.type = 1
            MovieSectionTableViewCell.finalSections = kidsModel
            MovieSectionTableViewCell.otherMovies = kidsModel?.results?[indexPath.row]
            
        default:
            MovieSectionTableViewCell.type = 1
            MovieSectionTableViewCell.finalSections = comedyModel
             MovieSectionTableViewCell.otherMovies = comedyModel?.results?[indexPath.row]
    }
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        view?.navigationController!.pushViewController(vc, animated: true)
}    
}


    




