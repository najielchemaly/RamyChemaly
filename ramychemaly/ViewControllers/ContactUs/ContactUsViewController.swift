//
//  ContactUsViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController, Storyboardable, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var textFieldFullname: UITextField!
    @IBOutlet weak var textFieldEmailAddress: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textViewMessage: UITextView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    
    let placeholder = "MESSAGE"
    var isTextViewEmpty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSubmitTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            let name = self.textFieldFullname.text
            let email = self.textFieldEmailAddress.text
            let phone = self.textFieldPhoneNumber.text
            let message = self.textViewMessage.text
            
            DispatchQueue.global(qos: .background).async {
                let response = appDelegate.services.contactUs(name: name!, email: email!, phone: phone!, message: message!)

                DispatchQueue.main.async {
                    self.resetFields()
                    
                    var alertTitle: String? = nil
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        alertTitle = "WOW!"
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
    
    func initializeViews() {
        textViewMessage.layer.cornerRadius = 30
        textViewMessage.textColor = Colors.lightGray
        
        textFieldFullname.delegate = self
        textFieldEmailAddress.delegate = self
        textFieldPhoneNumber.delegate = self
        textViewMessage.delegate = self
    }
    
    var errorMessage: String!
    func isValidData() -> Bool {
        if textFieldFullname.text == nil || textFieldFullname.text == "" {
            errorMessage = "Fullname field cannot be empty"
            return false
        }
        if textFieldEmailAddress.text == nil || textFieldEmailAddress.text == "" {
            errorMessage = "Email field cannot be empty"
            return false
        }
        if textFieldPhoneNumber.text == nil || textFieldPhoneNumber.text == "" {
            errorMessage = "Phone number field cannot be empty"
            return false
        }
        if textViewMessage.text == nil || textViewMessage.text == "" {
            errorMessage = "Message field cannot be empty"
            return false
        }
        
        return true
    }
    
    func resetFields() {
        textFieldFullname.text = nil
        textFieldEmailAddress.text = nil
        textFieldPhoneNumber.text = nil
        textViewMessage.text = placeholder
        textViewMessage.textColor = Colors.lightGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldFullname {
            textFieldEmailAddress.becomeFirstResponder()
        }
        if textField == textFieldEmailAddress {
            textFieldPhoneNumber.becomeFirstResponder()
        }
        if textField == textFieldPhoneNumber {
            textViewMessage.becomeFirstResponder()
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.lightGray {
            textView.text = ""
            textView.textColor = Colors.white
            
            isTextViewEmpty = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = Colors.lightGray
            
            isTextViewEmpty = true
        }
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
