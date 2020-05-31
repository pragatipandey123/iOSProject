//
//  LoginAndSignUp.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 28/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//
//
import Foundation
import UIKit
protocol UserFunctionality {
    
    func signupUser(Email: String, Password: String, confirmPassword: String, securityQues:String, view: UIViewController)
    func loginUSer(Email: String, Password: String, view: UIViewController)
    func logoutUser(view: UIViewController)
}

var allUsers : [[String]] = []
var user : [String] = []
var currentUser : [String] = []

class ManualLogin: UserFunctionality{
    
    func signupUser(Email: String, Password: String, confirmPassword: String, securityQues: String, view: UIViewController) {
        
        if UserDefaults.standard.object(forKey: "users") != nil{
        allUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        user.append(Email)
        user.append(Password)
        user.append(securityQues)
        
        //Check for the empty labels
        
        if Email == "" || Password.isEmpty || confirmPassword.isEmpty || securityQues == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
            
        }
            //Check for password and re-typed password
        else if Password != confirmPassword {
            let alertController = UIAlertController(title: "Alert", message: "Password does not match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
//If the user is already logged in with an account then they need to logout to use another one
        else if  currentUser.isEmpty == false {
            let alertController = UIAlertController(title: "Already Signed in", message: "Kindly Log-out to use a different login account", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
    //If no error occurs then complete the Sign up process
        else{
            //currentUser = user
            currentUser.removeAll()
            allUsers.append(user)
            user.removeAll()
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allUsers, forKey: "users")
            
            let myAlert = UIAlertController(title:"Alert", message:"Account has been succesfully created", preferredStyle: UIAlertController.Style.alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
            view.navigationController?.popViewController(animated: true)
                    }
               myAlert.addAction(okAction);
            view.present(myAlert, animated:true, completion:nil);
            currentUser.removeAll()
        }
        print(currentUser)
        print(user)
        print(allUsers)
       
    }
    
    func loginUSer(Email: String, Password: String, view: UIViewController) {
        let k = Email
        var temp : [String]?
        temp?.removeAll()
        if UserDefaults.standard.object(forKey: "users") != nil{
        allUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        
        if allUsers == [[]]
               {
                   let alertController = UIAlertController(title: "No user exists", message: "No one is logged in. First sign in to access the login functionality.", preferredStyle: .alert)
                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                   
                   alertController.addAction(defaultAction)
                   view.present(alertController, animated: true, completion: nil)
               }
    
        for i in 0...allUsers.count-1
        {
            if k == allUsers[i][0]
            {
                temp = allUsers[i]
            }
        }
        
        //Check for the empty labels
        
        if Email.isEmpty || Password.isEmpty
        {
            let alertController = UIAlertController(title: "Alert", message: "Please enter all the informations. All the informations are compulsory ", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
        
        user.append(Email ?? "")
        user.append(Password)

        //If the user is already logged in with an account then they need to logout to use another one
        if currentUser.isEmpty == false {
         let alertController = UIAlertController(title: "Alert", message: "Already logged In", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
        else if temp == nil{
            let alertController = UIAlertController(title: "User does not exist", message: "Kindly sign-in with an account first to use the login", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
         // If the password entered is wrong
            else if temp![1] != Password{
                let alertController = UIAlertController(title: "Password Incorrect", message: "Pleae login using the correct password. If you have forgotten your password then use the forgot password option.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
            }

            //Complete the login process
        else{
            currentUser = user
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allUsers, forKey: "users")
            temp?.removeAll()
            
           let myAlert = UIAlertController(title:"Alert", message:"Login Successfully", preferredStyle: UIAlertController.Style.alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
            view.navigationController?.popViewController(animated: true)
                    }
               myAlert.addAction(okAction);
            view.present(myAlert, animated:true, completion:nil);
            user.removeAll()
        }
        print(currentUser)
        print(user)
        print(allUsers)
        
        
    }
    
    func logoutUser(view: UIViewController) {
        
        if UserDefaults.standard.object(forKey: "users") != nil{
        allUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        
        //If no one is currently logged in
        if currentUser.isEmpty == true {
        
            let alertController = UIAlertController(title: "No one Logged in", message: "Kindly Login first to logout from it", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
        
        // Complete the log out process
        else{
            user.removeAll()
            currentUser.removeAll()
            
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allUsers, forKey: "users")
        }
        print(user)
        print(currentUser)
        print(allUsers)
    }
    
     func forgetPassword(Email: String, Password: String, confirmPassword: String, securityQues: String, view: UIViewController)
        {
            if UserDefaults.standard.object(forKey: "users") != nil{
            allUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
            }
            
            if UserDefaults.standard.object(forKey: "currentUser") != nil{
            currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
            }
            
            var temp : [String]?
            for i in 0...allUsers.count-1
            {
                if Email == allUsers[i][0]
                {
                    temp = allUsers[i]
                }
            }
            print("1\(temp)")
            
            //Currently a user is logged in
            if  currentUser.isEmpty == false {

                let alertController = UIAlertController(title: "Already Signed in", message: "Have You forgotten your password? Kindly logout and login again to change your password.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)

            }
            
            //User name entered is wrong
             if temp == nil
            {
                let alertController = UIAlertController(title: "No Such User exists", message: "The user name you have entered does not exists.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
            }
            
            //Check for password and re-typed password
            else if Password != confirmPassword {
                let alertController = UIAlertController(title: "Password Do not match", message: "Please re-type the password correctly", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
                
            }
                
            //Answer to the security question is wrong
            else if temp![2] != securityQues {
                let alertController = UIAlertController(title: "Wrong Answer", message: "Answer to the security question is wrong. Please try again.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
                
            }
            
            //Change the password
            else
            {
               
                for j in 0...allUsers.count-1
                {
                    if Email == allUsers[j][0]
                    {
                        allUsers[j].removeAll()
                        allUsers[j] += [Email , Password , securityQues]
                        
                    }
                }
                
                UserDefaults.standard.set(currentUser, forKey: "currentUser")
                UserDefaults.standard.set(allUsers, forKey: "users")
                temp?.removeAll()
                currentUser.removeAll()
                allUsers.removeAll()
                
               let myAlert = UIAlertController(title:"Alert", message:"Password Changed Succesfully", preferredStyle: UIAlertController.Style.alert);
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
                view.navigationController?.popViewController(animated: true)
                        }
                   myAlert.addAction(okAction);
                view.present(myAlert, animated:true, completion:nil);
                
            }
            currentUser.removeAll()
            allUsers.removeAll()
            print(allUsers)
        }

}






