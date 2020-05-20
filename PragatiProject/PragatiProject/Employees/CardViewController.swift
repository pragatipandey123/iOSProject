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
    
    // getting the employees data through api
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
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell {
            
            //To make the cell look like card view
            cell.backgroundColor = .clear
            cell.layer.masksToBounds = false
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowRadius = 4
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowColor = UIColor.white.cgColor
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderWidth = 3.0
            cell.contentView.layer.cornerRadius = 10
            
            cell.configureCell(data: responseModel?.data?[indexPath.row])
                   
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    



}
