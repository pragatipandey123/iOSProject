//
//  HomeViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 14/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

struct Movie{
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [MovieInfo]
}
struct MovieInfo{
    var original_name: String?
    var id: Int?
    var name: String?
    var vote_count: Int?
    var vote_average: Float?
    var first_air_date: String?
    var poster_path: String
    var genres: [Genre]?
    var original_language: String?
    var backdrop_path: String?
    let overview: String?
    var adult: Bool?
    var original_country: String?
    var popularity: String?
    var media_type: String
}

struct Genre:Decodable {
    let id: Int?
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageSliding: UIPageControl!
    
    var model = [Movie]()
    var array = [String]()
   
    var timer = Timer()
       var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource =  self
        
        let nib = UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil)
        imageCollectionView.register(nib, forCellWithReuseIdentifier: "sliderCell")
            
        pageSliding.numberOfPages = array.count
        pageSliding.currentPage = 0
              
        DispatchQueue.main.async {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
              }
        getData()
              
    }
    override func viewWillAppear(_ animated: Bool) {
        imageCollectionView.reloadData()
    }
    
    @objc func changeImage() {
           
           if counter<array.count {
            
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! ImageSliderCollectionViewCell
    
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(array[indexPath.row])")
      let dataFetch = URLSession.shared.dataTask(with: url!) { (data, response, error) in
              guard let response = data else {return}

               let finalImage = UIImage(data: response)
                  cell.imageSliding.image = finalImage
            
              }
          dataFetch.resume()
      
          return cell
    
      }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              
              return CGSize(width: view.frame.width, height: 250)
          }
      
    func getData(){
        let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let dataResponse = data else {  return }
            
         do{
             
            let jsonResponse = try JSONSerialization.jsonObject(with:
                                              dataResponse, options: [])
                      
            guard let jsonArray = jsonResponse as? [String : Any] else { return }
                        

            guard let jsonResults = jsonArray["results"] as? [[String: Any]] else { return }
                
                for i in 0...jsonResults.count - 1 {
                 
                    self.array.append(jsonResults[i]["backdrop_path"] as? String ?? " ")
                   }
              print(self.array)
            
         }
                    catch  {
                        print("Error")
                    }
                   
            }
                task.resume()
        
        }
        
}
        
    

    


