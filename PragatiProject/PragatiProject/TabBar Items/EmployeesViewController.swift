//
//  EmployeesViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 15/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Alamofire

//structure of an employee
struct Employees: Codable{
    let status: String?
    let data: [EmployeeData]
}

struct EmployeeData: Codable {
    var id: String?
    var employee_name: String?
    var employee_salary: String?
    var employee_age: String?
}

class EmployeesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var employeesTableView: UITableView!
    var responseModel: Employees?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeesTableView.delegate = self
        employeesTableView.dataSource = self
        getData()
        
        let nib = UINib.init(nibName: "EmployeeTableViewCell", bundle: nil)
        employeesTableView.register(nib, forCellReuseIdentifier: "employeeCell")
    }
    
    //calling of an api
    func getData() {
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
                
                self?.employeesTableView.reloadData()
        }
    }
    
    //MARK: TableView Delegates and DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseModel?.data.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as? EmployeeTableViewCell {
            cell.configureCell(data: responseModel?.data[indexPath.row])
                      return cell
                  }
                  return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    


}
