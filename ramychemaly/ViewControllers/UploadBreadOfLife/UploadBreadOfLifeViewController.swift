//
//  UploadBreadOfLifeViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/13/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class UploadBreadOfLifeViewController: BaseViewController, Storyboardable, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
   
    @IBOutlet weak var textFieldType: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    let types: [String] = [
        "Quote",
        "Bible"
    ]
    
    let placeholder = "DESCRIPTION"
    
    var pickerView: UIPickerView!
    var isTextViewEmpty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
        self.setupPickerView()
        self.setupDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSubmitTapped(_ sender: Any) {
        if isValidData() {
            self.showLoader()
            
            let type = self.textFieldType.text
            let title = self.textFieldTitle.text
            let message = self.textViewDescription.text
            
            DispatchQueue.global(qos: .background).async {
                let response = appDelegate.services.uploadBreadOfLife(type: type!, title: title!, message: message!)
                
                DispatchQueue.main.async {
                    self.resetFields()
                    
                    var alertTitle: String? = nil
                    if response?.status == ResponseStatus.SUCCESS.rawValue {
                        alertTitle = "Bread Of Life"
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
        self.textViewDescription.layer.cornerRadius = 30
        
        self.textViewDescription.textColor = Colors.lightGray
        self.textViewDescription.text = placeholder
    }
    
    func setupPickerView() {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.textFieldType.inputView = self.pickerView
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        toolbar.sizeToFit()
        toolbar.barStyle = .default
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.dismissKeyboard))
        cancelButton.tintColor = Colors.appBlue
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: self, action: #selector(self.doneButtonTapped))
        doneButton.tintColor = Colors.appBlue
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [cancelButton, flexibleSpace, doneButton]
        
        self.textFieldType.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        if types.count > 0 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            let type = types[row]
            self.textFieldType.text = type
        }
        
        self.dismissKeyboard()
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func setupDelegate() {
        self.textFieldTitle.delegate = self
        self.textViewDescription.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldTitle {
            textViewDescription.becomeFirstResponder()
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
    
    func resetFields() {
        self.textFieldType.text = nil
        self.textFieldTitle.text = nil
        self.textViewDescription.text = nil
    }
    
    var errorMessage: String!
    func isValidData() -> Bool {
        if textFieldType.text == nil || textFieldType.text == "" {
            errorMessage = NSLocalizedString("Type field cannot be empty", comment: "")
            return false
        }
        if textFieldTitle.text == nil || textFieldTitle.text == "" {
            errorMessage = NSLocalizedString("Title field cannot be empty", comment: "")
            return false
        }
        if textViewDescription.text == nil || textViewDescription.text == "" {
            errorMessage = NSLocalizedString("Description field cannot be empty", comment: "")
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
