//
//  ListingViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 19/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

struct BaseModel: Codable {
     var status: String?
     var data: [Employee]?
 }

struct Employee: Codable {
  var id: String?
  var employee_name: String?
  var employee_salary: String?
  var employee_age: String?
}

class ListingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    
    var responseModel: BaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let nib = UINib.init(nibName: "ListTableViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "listCell")
        getEmployeeData()
    }
    
    //Getting the data of employess through api
    func getEmployeeData() {
        AF.request("http://dummy.restapiexample.com/api/v1/employees", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData { [weak self] response in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let result = try decoder.decode(BaseModel.self, from: data)
                        self?.responseModel = result
                        print(result)
                    } catch { print(error) }
                }
                self?.listTableView.reloadData()
        }
    }
    
    //MARK: TableView Delegates and DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListTableViewCell {
            cell.configure(data: responseModel?.data?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
