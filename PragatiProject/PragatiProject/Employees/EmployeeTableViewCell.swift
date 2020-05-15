//
//  EmployeeTableViewCell.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 15/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empSalary: UILabel!
    @IBOutlet weak var empId: UILabel!
    @IBOutlet weak var empAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: EmployeeData?) {
        empId.text = data?.id
        empName.text = data?.employee_name
        empSalary.text = data?.employee_salary
        empAge.text = data?.employee_age
    }
    
    
}
