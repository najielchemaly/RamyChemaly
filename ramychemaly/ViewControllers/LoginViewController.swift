//
//  LoginViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import NVActivityIndicatorView

class LoginViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonContinueWithFB: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    
    var loginButton: FBSDKLoginButton!
    var loginManager: FBSDKLoginManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
        self.setupDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector:#selector(navigateToHome), userInfo: nil, repeats: false)
            
            self.dismissKeyboard()
        } else {
            self.showAlert(message: errorMessage, style: .alert)
        }
    }
    
    @IBAction func buttonForgotPasswordTapped(_ sender: Any) {
        self.redirectToVC(storyboardId: StoryboardIds.ForgotPasswordViewController, type: .present)
    }
    
    @IBAction func buttonSignupTapped(_ sender: Any) {
        self.redirectToVC(storyboardId: StoryboardIds.SignupViewController, type: .fromBottom)
    }
    
    @IBAction func buttonContinueWithFBTapped(_ sender: Any) {
        // show loader
        if (FBSDKAccessToken.current()) != nil
            //            , currentAccessToken.appID != FBSDKSettings.appID()
        {
            loginManager.logOut()
        }
        
        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print(error!)
            } else if (result?.isCancelled)! {
                DispatchQueue.main.async {
                    // hide loader
                }
            } else if result?.grantedPermissions != nil {
                self.getFacebookParameters()
            }
        })
    }
    
    func initializeViews() {
        self.buttonForgotPassword.setAttributedText(firstText: "OOPS! ", secondText: "I FORGOT MY PASSWORD", color: .white)
        self.buttonSignup.setAttributedText(firstText: "NEW USER? ", secondText: "SIGN UP HERE", color: Colors.appBlue)
        
        self.loginButton = FBSDKLoginButton()
        self.loginButton.readPermissions = ["public_profile", "email"]
        
        self.loginManager = FBSDKLoginManager()
    }
    
    func getFacebookParameters(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, gender, location, picture, birthday"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if (error == nil)
            {
                if let dict = result as? NSDictionary {
                    if let gender = (dict.object(forKey: "gender") as? String) {
                        
                    }
                    if let id = (dict.object(forKey: "id") as? String) {
                       
                    }
                    if let name = (dict.object(forKey: "name") as? String) {
                       
                    }
                    if let email = (dict.object(forKey: "email") as? String) {
                        
                    }
                    if let picture = (dict.object(forKey: "picture") as? NSDictionary) {
                        if let data = picture.object(forKey: "data") as? NSDictionary {
                            if let url = data.object(forKey: "url") as? String {

                            }
                        }
                    }
                    DispatchQueue.global(qos: .background).async {
                        let response = Services.init().facebookLogin()
                        if response?.status == ResponseStatus.SUCCESS.rawValue {
                            if let json = response?.json?.first {
                                if let jsonUser = json["user"] as? NSDictionary {
                                    self.saveUserInUserDefaults()
                                    
                                    DispatchQueue.main.async {
                                        
                                    }
                                }
                            }
                        } else if response?.status == ResponseStatus.UNAUTHORIZED.rawValue {
                            DispatchQueue.main.async {
                                
                            }
                        } else {
                            if let message = response?.message {
                                DispatchQueue.main.async {
                                    self.showAlert(message: message, style: .alert)
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            // hide loader
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        // hide loader
                    }
                }
            } else {
                DispatchQueue.main.async {
                    // hide loader
                }
            }
        })
    }
    
    func setupDelegates() {
        self.textFieldEmail.delegate = self
        self.textFieldPassword.delegate = self
    }
    
    var errorMessage: String!
    func isValidData() -> Bool {
        
        if textFieldEmail.text == nil || textFieldEmail.text == "" {
            errorMessage = "Email field cannot be empty"
            return false
        }
        if textFieldPassword.text == nil || textFieldPassword.text == "" {
            errorMessage = "Password field cannot be empty"
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            self.dismissKeyboard()
        }
        
        return true
    }
    
    @objc func navigateToHome() {
        self.hideLoader()
        self.redirectToVC(storyboardId: StoryboardIds.InitialMenuViewController, type: .push)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
