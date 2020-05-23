//
//  SliderTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 23/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

struct Movie: Codable {
 var page : Int?
 var results : [MovieData]
 var totalPages : Int?
 var totaResults : Int?
 }
struct MovieData: Codable {
 var id: Int?
 var video: Bool?
 var vote_count: Int?
 var vote_average: Float?
 var title: String?
 var release_date: String?
 var original_language: String?
 var original_title: String?
 var backdrop_path: String?
 var adult: Bool?
 var overview: String?
 var poster_path: String?
 var popularity: Float?
 var media_type: String?
}


class SliderTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageSliding: UIPageControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var model: Movie?
    var counter = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCollectionView.delegate = self
        imageCollectionView.dataSource =  self
        setTimer()
        getData()
        
        let nib = UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil)
        imageCollectionView.register(nib, forCellWithReuseIdentifier: "sliderCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Set Timer to switch between the Images
    func setTimer() {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SliderTableViewCell.changeImage), userInfo: nil,
    repeats: true)
      }

    @objc func changeImage() {
           pageSliding.numberOfPages = model?.results.count ?? 0
           self.pageSliding.currentPage = counter
        if counter<model?.results.count ?? 0 {
               let index = IndexPath(item: counter, section: 0)
               self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageSliding.currentPage = counter
              counter += 1
        }
           else {
               counter = 0
               let index = IndexPath(item: counter, section: 0)
               self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageSliding.currentPage = counter
               counter = 1
           }
       }
    
    //Getting the data from the api
    func getData() {
    AF.request("https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66", method: .get, parameters: nil, encoding: URLEncoding.default)
              .responseData { [weak self] response in
                  switch response.result {
                  case .failure(let error):
                      print(error)
                  case .success(let data):
                      do {
                          let decoder = JSONDecoder()
                          decoder.keyDecodingStrategy = .useDefaultKeys
                          let result = try decoder.decode(Movie.self, from: data)
                          self?.model = result
                          print(result)
                      } catch { print(error) }
                  }
                  self?.imageCollectionView.reloadData()
          }
      }
    
     
      //MARK: CollectionView Delegates and DataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return model?.results.count ?? 0
         }
         
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! ImageSliderCollectionViewCell
       
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(model!.results[indexPath.row].backdrop_path!)")
          let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
           guard let response = data else {return}
           
           let finalImage = UIImage(data: response)
            DispatchQueue.main.async {
               cell.imageSliding.image = finalImage
           }
       }
           dataFetch.resume()
             return cell
         }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                 
           return CGSize(width: imageCollectionView.frame.width, height: 300)
           }
       
    
}
