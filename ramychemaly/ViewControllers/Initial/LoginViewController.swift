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
import FirebaseMessaging
import NVActivityIndicatorView
import youtube_ios_player_helper
import CoreData

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
        
//        var context: NSManagedObjectContext!
//        if #available(iOS 10.0, *) {
//            context = appDelegate.persistentContainer.viewContext
//        }
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
//        let user = NSManagedObject(entity: userEntity!, insertInto: context)
//        user.setValue("Naji El Chemaly", forKey: "fullName")
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        request.predicate = NSPredicate(format: "fullName = %@", "Naji El Chemaly")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "fullName") as! String)
//            }
//
//        } catch {
//            print("Failed")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            let email = self.textFieldEmail.text
            let password = self.textFieldPassword.text
            DispatchQueue.global(qos: .background).async {
                let response = appDelegate.services.login(email: email!, password: password!)
                
                DispatchQueue.main.async {
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        if let json = response?.json?.first {
                            if let jsonUser = json["user"] as? NSDictionary {
                                if let user = User.init(dictionary: jsonUser) {
                                    currentUser = user
                                    
                                    self.saveUserInUserDefaults()
                                    
                                    self.navigateToHome()
                                }
                            }
                        }
                    } else if let message = response?.message {
                        self.showAlertView(message: message)
                    }
                    
                    self.hideLoader()
                }
            }
        } else {
            self.showAlertView(message: errorMessage)
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
                currentUser = User()
                currentUser.facebook_token = result?.token.tokenString
                
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
        
        Messaging.messaging().unsubscribe(fromTopic: "/topics/ramychemalynews")
    }
    
    func getFacebookParameters(){
        self.showLoader()
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, gender, location, picture, birthday"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if (error == nil)
            {
                if let dict = result as? NSDictionary {
                    if let gender = (dict.object(forKey: "gender") as? String) {
                        currentUser.gender = gender
                    }
                    if let id = (dict.object(forKey: "id") as? String) {
                       currentUser.facebook_id = id
                    }
                    if let name = (dict.object(forKey: "name") as? String) {
                       currentUser.fullname = name
                    }
                    if let email = (dict.object(forKey: "email") as? String) {
                       currentUser.email = email
                    }
                    if let picture = (dict.object(forKey: "picture") as? NSDictionary) {
                        if let data = picture.object(forKey: "data") as? NSDictionary {
                            if let url = data.object(forKey: "url") as? String {
                                currentUser.avatar = url
                            }
                        }
                    }
                    DispatchQueue.global(qos: .background).async {
                        let response = appDelegate.services.facebookLogin(user: currentUser)
                        DispatchQueue.main.async {
                            if response?.status == ResponseStatus.SUCCESS.rawValue {
                                if let json = response?.json?.first {
                                    if let jsonUser = json["user"] as? NSDictionary {
                                        if let user = User.init(dictionary: jsonUser) {
                                            currentUser = user
                                            
                                            if currentUser.avatar == nil {
                                                SelectAvatarViewController.comingFrom = .signup
                                                self.redirectToVC(storyboardId: StoryboardIds.SelectAvatarViewController, type: .push)
                                            } else {
                                                self.navigateToHome()
                                            }
                                        }
                                    }
                                }
                            } else {
                                if let message = response?.message {
                                    self.showAlertView(message: message, doneTitle: "Ok")
                                }
                            }
                            
                            self.hideLoader()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.hideLoader()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.hideLoader()
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
        self.redirectToVC(storyboardId: StoryboardIds.InitialMenuViewController, type: .push)
    }
    
    func dummyData() {
        currentUser = User()
        currentUser.id = "1"
        currentUser.fullname = "Naji Chemaly"
        currentUser.email = "najielchemaly@gmail.com"
        currentUser.phone = "+96171169428"
        currentUser.role = "admin"
        currentUser.avatar = "ramy1"
        
        self.hideLoader()
        self.saveUserInUserDefaults()
        self.navigateToHome()
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
