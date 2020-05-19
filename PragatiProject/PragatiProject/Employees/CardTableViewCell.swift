//
//  CardTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 19/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeID: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeSalary: UILabel!
    @IBOutlet weak var employeeAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: EmployeeModel?) {
           employeeID.text = "ID: \(data?.id ?? "")"
        employeeName.text = "Name: \(data?.employee_name ?? "")"
           employeeSalary.text = "Salary: Rs.\(data?.employee_salary ?? "")"
           employeeAge.text = "Age: \(data?.employee_age ?? "")"
       }
    
}
