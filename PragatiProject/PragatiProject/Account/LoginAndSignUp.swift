//
//  LoginAndSignUp.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 28/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//protocol UserFunctionality {
//    func loginUser(Email: String, Password: String, view: UIViewController)
//    func signUpUser(Email: String, Password: String, ConfirmPassword: String, view: UIViewController)
//    func logOutUser(view: UIViewController)
//}
//
//
//
//class ManualLogin: UserFunctionality {
//
//    var user = [String]()
//    var passwordArr = [String]()
//
//    func loginUser(Email: String, Password: String, view: UIViewController) {
//        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")as? [String] ?? [String]()
//
//        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")as? [String] ?? [String]()
//
//        //check for empty fields
//         if(Email.isEmpty || Password.isEmpty) {
//
//             let myAlert = UIAlertController(title:"Alert", message:"Email and Password required", preferredStyle: UIAlertController.Style.alert);
//
//             let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
//
//             myAlert.addAction(okAction);
//             view.present(myAlert, animated:true, completion:nil);
//        }
//
//        if (userEmailStored != user || userPasswordStored != passwordArr) {
//
//            let myAlert = UIAlertController(title:"Alert", message:"Email/Password does not match", preferredStyle: UIAlertController.Style.alert);
//
//                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
//
//                myAlert.addAction(okAction);
//                view.present(myAlert, animated:true, completion:nil);
//
//        }
//
//        if userEmailStored == user {
//            if userPasswordStored == passwordArr
//            {
//                // Login is successfull
//                UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
//                UserDefaults.standard.synchronize()
//                view.navigationController?.popViewController(animated: true)
//    }
//        }
//
//
//    }
//
//
//    func signUpUser(Email: String, Password: String, ConfirmPassword: String, view: UIViewController) {
//
//
//               //check for empty fields
//        if(Email.isEmpty || Password.isEmpty || ConfirmPassword.isEmpty) {
//
//            let myAlert = UIAlertController(title:"Alert", message:"All fields are required", preferredStyle: UIAlertController.Style.alert);
//
//            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
//
//            myAlert.addAction(okAction);
//            view.present(myAlert, animated:true, completion:nil);
//
//               }
//
//        //Check if passwords match
//        if (Password != ConfirmPassword) {
//            let myAlert = UIAlertController(title:"Alert", message:"Password does not match", preferredStyle: UIAlertController.Style.alert);
//
//            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
//
//            myAlert.addAction(okAction);
//            view.present(myAlert, animated:true, completion:nil);
//        }
//
//        //Checked for a valid password
//        let cleanedPassword = Password.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        if (isPasswordValid(cleanedPassword) == false) {
//            let myAlert = UIAlertController(title:"Alert", message:"Please make sure that the password must be of 8 characters and contains atleast one special character and one character", preferredStyle: UIAlertController.Style.alert);
//
//            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
//
//            myAlert.addAction(okAction);
//            view.present(myAlert, animated:true, completion:nil);
//        }
//
//        //Store Data
//        user.append(Email)
//        passwordArr.append(Password)
//        UserDefaults.standard.set(user, forKey: "userEmail")
//        UserDefaults.standard.set(passwordArr, forKey: "userPassword")
//        UserDefaults.standard.synchronize()
//
//        // Display alert message
//        let myAlert = UIAlertController(title:"Alert", message:"Account has been succesfully created", preferredStyle: UIAlertController.Style.alert);
//
//        let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
//            view.navigationController?.popViewController(animated: true)
//        }
//
//        myAlert.addAction(okAction);
//        view.present(myAlert, animated:true, completion:nil);
//
//        print("1\(user)")
//        print("2\(passwordArr)")
//
//    }
//
//    func logOutUser(view: UIViewController) {
//
//     UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//
//    }
//
//    func isPasswordValid(_ password : String) -> Bool{
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
//    }
//
//}



