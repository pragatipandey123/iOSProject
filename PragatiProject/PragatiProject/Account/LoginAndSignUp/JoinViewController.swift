//
//  SignUpViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 26/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Firebase


class JoinViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var securityQuesTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var register = ManualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        register.signupUser(Email: emailTextField.text ?? "", Password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "", securityQues: securityQuesTextField.text ?? "", view: self)
       
   }
    
    

}
