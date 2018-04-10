//
//  NotificationDetailViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/9/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class NotificationDetailViewController: BaseViewController {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonGetDirection: UIButton!
    
    var notification: Notification = Notification()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = "RAMY'S MASS"
    }
    
    func initializeViews() {
        if let imgUrl = notification.img_url {
            self.imageViewIcon.kf.setImage(with: URL(string: Services.getMediaUrl() + imgUrl))
        }
        
        self.textViewDescription.text = notification.desc
    }
    
    @IBAction func buttonGetDirectionTapped(_ sender: Any) {
        if let location = notification.location {
            let coordinates = location.split{$0 == ","}.map(String.init)
            if let latitude = coordinates.first, let longitude = coordinates.last {
                if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps:")!) {
                    let latitudeString = "\(latitude)".trimmingCharacters(in: .whitespacesAndNewlines)
                    let longitudeString = "\(longitude)".trimmingCharacters(in: .whitespacesAndNewlines)
                    let urlString = "comgooglemaps://?ll=" + latitudeString + "," + longitudeString
                    UIApplication.shared.openURL(URL(string: urlString)!)
                }
                else {
                    let string = "http://maps.google.com/maps/dir/?api=1&destination=\(latitude),\(longitude)"
                    UIApplication.shared.openURL(URL(string: string)!)
                }
            }
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
