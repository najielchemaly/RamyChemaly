//
//  ContactUsViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController, Storyboardable {

    @IBOutlet weak var textFieldFullname: UITextField!
    @IBOutlet weak var textFieldEmailAddress: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textViewMessage: UITextView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    
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
        
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismissVC()
    }
    
    func initializeViews() {
        self.textViewMessage.layer.cornerRadius = 30
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
