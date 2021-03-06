//
//  BaseViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/4/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate {
    func didFinishPickingMedia(data: UIImage?)
    func didCancelPickingMedia()
}

class BaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePickerDelegate: ImagePickerDelegate!
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentVC = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func handleCameraTap(sender: UIButton? = nil) {
        let optionActionSheet = UIAlertController(title: NSLocalizedString("Select Source", comment: ""), message: nil, preferredStyle: .actionSheet)
        optionActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: openCamera))
        optionActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Library", comment: ""), style: .default, handler: openPhotoLibrary))
        optionActionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        present(optionActionSheet, animated: true, completion: nil)
    }
    
    func openCamera(action: UIAlertAction) {
        self.imagePickerController.sourceType = .camera
        
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func openPhotoLibrary(action: UIAlertAction) {
        self.imagePickerController.sourceType = .photoLibrary
        
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var pickedImage: UIImage? = nil
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedImage = image
        }
        
        self.imagePickerDelegate.didFinishPickingMedia(data: pickedImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerDelegate.didCancelPickingMedia()
        
        dismiss(animated: true, completion: nil)
    }
    
    func hasToolBar() -> Bool {
        return false
    }
    
    func saveUserInUserDefaults() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: "")
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "user")
        userDefaults.synchronize()
    }
    
    func openURL(url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func buttonGetDirectionsTapped(sender: UIButton) {
        let location = ""
        let coordinates = location.split{$0 == ","}.map(String.init)
        if let latitude = coordinates.first, let longitude = coordinates.last {
            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps:")!) {
                let urlString = "comgooglemaps://?ll=\(latitude),\(longitude)"
                UIApplication.shared.openURL(URL(string: urlString)!)
            }
            else {
                let string = "http://maps.google.com/maps/dir/?api=1&destination=\(latitude),\(longitude)"
                UIApplication.shared.openURL(URL(string: string)!)
            }
        }
    }

    func logout() {
        DispatchQueue.main.async {
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "user")
            userDefaults.synchronize()
            
            // hide loader
            
            // set login as root
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
