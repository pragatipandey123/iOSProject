//
//  CardViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 19/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

struct Employees: Codable {
    var status: String?
    var data: [EmployeeModel]?
}

struct EmployeeModel: Codable {
    var id: String?
    var employee_name: String?
    var employee_salary: String?
    var employee_age: String?
}

class CardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var dataTableView: UITableView!
    
    var responseModel: Employees?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        let nib = UINib.init(nibName: "CardTableViewCell", bundle: nil)
        dataTableView.register(nib, forCellReuseIdentifier: "cardCell")
        
        getEmployeeData()
        
    }
    

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
                        let result = try decoder.decode(Employees.self, from: data)
                        self?.responseModel = result
                        print(result)
                    } catch { print(error) }
                }
                
                self?.dataTableView.reloadData()
                // Stop Spinner
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell {
            cell.configureCell(data: responseModel?.data?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }



}
