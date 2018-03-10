//
//  SignupViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupDelegates()            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSignupTapped(_ sender: Any) {
        if !isValidData() {
            self.redirectToVC(storyboardId: StoryboardIds.SelectAvatarViewController, type: .push)
        } else {
            self.showAlertView(message: errorMessage, doneTitle: "Ok")
        }
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.popVC(fromTop: true)
    }
    
    func setupDelegates() {
        self.textFieldEmail.delegate = self
        self.textFieldPassword.delegate = self
    }
    
    var errorMessage: String!
    func isValidData() -> Bool {
        if textFieldFullName.text == nil || textFieldFullName.text == "" {
            errorMessage = "Full name field cannot be empty"
            return false
        }
        if textFieldEmail.text == nil || textFieldEmail.text == "" {
            errorMessage = "Email field cannot be empty"
            return false
        }
        if textFieldPhoneNumber.text == nil || textFieldPhoneNumber.text == "" {
            errorMessage = "Phone number field cannot be empty"
            return false
        }
        if textFieldEmail.text == nil || textFieldEmail.text == "" {
            errorMessage = "Email field cannot be empty"
            return false
        }
        if textFieldPassword.text == nil || textFieldPassword.text == "" {
            errorMessage = "Password field cannot be empty"
            return false
        }
        if textFieldPassword.text != textFieldConfirmPassword.text {
            errorMessage = "Passwords do not match"
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
