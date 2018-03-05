//
//  LoadingViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/4/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    var timer = Timer()
    var indexProgress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressView.progress = 0
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector:#selector(setProgressBar), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @objc func setProgressBar()
    {
        indexProgress += 0.05
        progressView.setProgress(indexProgress/3, animated: true)
        
        if indexProgress >= 3 {
            timer.invalidate()
            
            self.redirectToVC(storyboardId: StoryboardIds.LoginViewController, type: .push)
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
