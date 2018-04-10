//
//  WebViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/5/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, Storyboardable, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    static var comingFrom = WebViewComingFrom.none
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupWebview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if WebViewController.comingFrom.hashValue == WebViewComingFrom.terms.hashValue {
            self.toolbarView.labelTitle.text = "TERMS & CONDITIONS"
        } else if WebViewController.comingFrom.hashValue == WebViewComingFrom.privacy.hashValue {
            self.toolbarView.labelTitle.text = "PRIVACY POLICY"
        }
    }
    
    func setupWebview() {
        self.webView.delegate = self
        
        if WebViewController.comingFrom.hashValue == WebViewComingFrom.terms.hashValue {
            if let termsUrl = URL.init(string: termsUrlString) {
                self.webView.loadRequest(URLRequest.init(url: termsUrl))
            }
        } else if WebViewController.comingFrom.hashValue == WebViewComingFrom.privacy.hashValue {
            if let privacyUrl = URL.init(string: privacyUrlString) {
                self.webView.loadRequest(URLRequest.init(url: privacyUrl))
            }
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showLoader()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideLoader()
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
