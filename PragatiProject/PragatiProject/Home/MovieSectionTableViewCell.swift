//
//  MovieSectionTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 23/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

    import UIKit
    import Alamofire

    struct PopularityData: Codable {
    var page: Int?
    var results: [Popularity]?
    var total_pages: Int?
    var total_results: Int?
}
    struct Popularity: Codable {
    var backdrop_path: String?
     var poster_path: String?
     var title: String?
     var vote_average: Double?
    }

    class MovieSectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
       
        
    @IBOutlet weak var movieCollectionView: UICollectionView!
        
        
        var popularityModel: PopularityData?
        
        override func awakeFromNib() {
            super.awakeFromNib()
           
            movieCollectionView.delegate = self
            movieCollectionView.dataSource = self
            
            getThePopularity()
            
            let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            movieCollectionView.register(nib, forCellWithReuseIdentifier: "movieCollection")
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
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
                        let result = try decoder.decode(PopularityData.self, from: data)
                            self?.popularityModel = result
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
            
            let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollection", for: indexPath) as! MovieCollectionViewCell
            cell.imageName.text = ( popularityModel?.results?[indexPath.row].title)
            cell.movieType.text = "Action & Adventure"
            
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
        
    }
    




