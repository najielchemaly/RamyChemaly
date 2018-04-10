//
//  EditProfileViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldFullname: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fillUserInfo()
        self.setupDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSaveTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            let userId = currentUser.id
            let name = textFieldFullname.text
            let email = textFieldEmail.text
            let phone = textFieldPhone.text
            
            DispatchQueue.global(qos: .background).async {
                let response = appDelegate.services.editUser(id: userId!, fullname: name!, phoneNumber: phone!, email: email!)
                
                DispatchQueue.main.async {
                    var alertTitle: String? = nil
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        alertTitle = "WOW!"
                        
                        if let json = response?.json?.first {
                            if let jsonUser = json["user"] as? NSDictionary {
                                if let user = User.init(dictionary: jsonUser) {
                                    currentUser = user
                                    
                                    self.saveUserInUserDefaults()
                                }
                            }
                        }
                    }
                    
                    if let message = response?.message {
                        self.showAlertView(title: alertTitle, message: message)
                    }
                    
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        self.alertView.buttonDone.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
                    }
                    
                    self.hideLoader()
                }
            }
        } else {
            self.showAlertView(message: errorMessage)
        }
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismissVC()
    }
    
    func fillUserInfo() {
        textFieldFullname.text = currentUser.fullname
        textFieldEmail.text = currentUser.email
        textFieldPhone.text = currentUser.phone
    }
    
    func setupDelegate() {
        textFieldFullname.delegate = self
        textFieldEmail.delegate = self
        textFieldPhone.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldFullname {
            textFieldEmail.becomeFirstResponder()
        } else if textField == textFieldEmail {
            textFieldPhone.becomeFirstResponder()
        } else {
            self.dismissKeyboard()
        }
        
        return true
    }
    
    var errorMessage: String!
    func isValidData() -> Bool {
        if textFieldFullname.text == nil || textFieldFullname.text == "" {
            errorMessage = "Fullname field cannot be empty"
            return false
        }
        if textFieldEmail.text == nil || textFieldEmail.text == "" {
            errorMessage = "Email field cannot be empty"
            return false
        }
        if textFieldPhone.text == nil || textFieldPhone.text == "" {
            errorMessage = "Phone number field cannot be empty"
            return false
        }
        
        return true
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
