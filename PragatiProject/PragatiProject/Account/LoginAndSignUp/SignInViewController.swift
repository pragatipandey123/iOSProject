//
//  SignInViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 26/03/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class SignInViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate{
  
    @IBOutlet weak var fbLogin: FBLoginButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    var login = ManualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        fbLogin.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentuser()
    }
    
    // logIn button action
    @IBAction func logInTapped(_ sender: UIButton) {

        login.loginUSer(Email: emailText.text ?? "", Password: password.text ?? "", view: self)
    }
    
    //MARK: Google SignIn
    @IBAction func googleSignTapped(_ sender: GIDSignInButton) {
        
        if Auth.auth().currentUser != nil {
        let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert);
                  
        let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                  
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
              }
       GIDSignIn.sharedInstance().signIn()
    }
    
    // GDSign Delegate
      func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In")
        if let error = error {
          print(error.localizedDescription)
          return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        
       // When user is signed in
        if Auth.auth().currentUser != nil {
            let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
            
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
            print(self.currentuser())
        }
        
        else {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
          if let error = error {
            print("Login error: \(error.localizedDescription)")
            return
          }
            if error != nil {
                return
            }
            else {
                let myAlert = UIAlertController(title:"Alert", message:"User successfully SignIn", preferredStyle: UIAlertController.Style.alert);
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
                self.currentuser()
                print(self.currentuser())
            }
        })
            
        }
      }
    
 //to show which user is logged in
    func currentuser() {
        if let currentUser = Auth.auth().currentUser {
        UserDefaults.standard.set(true, forKey: "LoggedIn")
            UserDefaults.standard.synchronize()
        userName.text = " You are login as - " + (currentUser.displayName ?? "Display name not found")
        }
    }

    
//MARK: FaceBook login and logout
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        else {
             if Auth.auth().currentUser != nil {
            let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert);
                       
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                       
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
            }
                
             else {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
              Auth.auth().signIn(with: credential, completion: { (user, error) in
              if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
              }
                if error != nil {
                    return
                }
                else {
                    let myAlert = UIAlertController(title:"Alert", message:"User successfully SignIn", preferredStyle: UIAlertController.Style.alert);
                    
                    let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                    
                    myAlert.addAction(okAction);
                    self.present(myAlert, animated:true, completion:nil);
                    self.currentuser()
                }
            })
        }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("UserLoggedOut")
         LoginManager().logOut() 
            userName.alpha = 0
        try! Auth.auth().signOut()
    }
    
    //LogOut Button Action
    @IBAction func logOutTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        try! Auth.auth().signOut()
        userName.alpha = 0
        login.logoutUser(view: self)
       
    }
    
    //Forget Password Button Action
    @IBAction func forgetPasswordTapped(_ sender: Any) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ResetPasswordViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
