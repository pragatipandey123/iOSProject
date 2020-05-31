//
//  ResetPasswordViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 31/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit


class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailConfirm: UITextField!
    @IBOutlet weak var confirmSecurityQuestion: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
   var reset = ManualLogin()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changedPasswordTapped(_ sender: Any) {
        
        reset.forgetPassword(Email: emailConfirm.text ?? "", Password: newPassword.text ?? "", confirmPassword: confirmNewPassword.text ?? "", securityQues: confirmSecurityQuestion.text ?? "", view: self)
    }

}

