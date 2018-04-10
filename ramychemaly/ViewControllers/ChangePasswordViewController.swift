//
//  ChangePasswordViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/8/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonChange: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonChangeTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            let oldPassword = self.textFieldCurrentPassword.text
            let newPassword = self.textFieldNewPassword.text
            let userId = currentUser.id
            DispatchQueue.global(qos: .background).async {
                let response = appDelegate.services.changePassword(id: userId!, oldPassword: oldPassword!, newPassword: newPassword!)
                
                DispatchQueue.main.async {
                    var alertTitle: String? = nil
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        alertTitle = "WOW!"
                        
                        self.alertView.buttonDone.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
                    }
                    
                    if let message = response?.message {
                        self.showAlertView(title: alertTitle, message: message)
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
    
    var errorMessage: String!
    func isValidData() -> Bool {
        if textFieldCurrentPassword.text == nil || textFieldCurrentPassword.text == "" {
            errorMessage = "Current password field cannot be empty"
            return false
        }
        if textFieldNewPassword.text == nil || textFieldNewPassword.text == "" {
            errorMessage = "New password field cannot be empty"
            return false
        }
        if textFieldNewPassword.text != textFieldConfirmPassword.text {
            errorMessage = "Passwords do not match"
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
