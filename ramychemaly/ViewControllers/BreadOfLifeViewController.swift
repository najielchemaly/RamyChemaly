//
//  BreadOfLifeViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FSPagerView

class BreadOfLifeViewController: BaseViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    @IBOutlet weak var pagerView: FSPagerView!
    
    var breadOfLifes: [BreadOfLife] = [BreadOfLife]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupPagerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = "BREAD OF LIFE"
    }
    
    func setupPagerView() {
        self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        self.pagerView.register(UINib.init(nibName: "BreadOfLifeViewCell", bundle: nil), forCellWithReuseIdentifier: "BreadOfLifeViewCell")
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "BreadOfLifeViewCell", at: index) as? BreadOfLifeViewCell {
            
            cell.contentView.layer.shadowRadius = 0
            cell.layer.cornerRadius = 20
            
            return cell
        }
        
        return FSPagerViewCell()
    }
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return breadOfLifes.count
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
