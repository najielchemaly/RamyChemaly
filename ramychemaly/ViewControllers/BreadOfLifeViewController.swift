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
    @IBOutlet weak var textFieldMonth: UITextField!
    @IBOutlet weak var buttonPrevious: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    var breadOfLifes: [BreadOfLife] = [BreadOfLife]()
    var maxNumberOfMonths: Int = 0
    var monthNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getBreadOfLife()
        self.initializeViews()
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
    
    func getBreadOfLife() {
        self.showLoader()
        DispatchQueue.global(qos: .background).async {
            let response = appDelegate.services.getBreadOfLife()
            
            DispatchQueue.main.async {
                self.dummyData()
                if response?.status == ResponseStatus.SUCCESS.rawValue {
                    if let json = response?.json?.first {
                        if let jsonArray = json["breadoflife"] as? [NSDictionary] {
                            self.breadOfLifes = [BreadOfLife]()
                            for json in jsonArray {
                                let breadOfLife = BreadOfLife.init(dictionary: json)
                                self.breadOfLifes.append(breadOfLife!)
                            }
                        }
                    }
                }
                
                self.hideLoader()
                
                if self.breadOfLifes.count == 0 {
                    self.addEmptyView(message: "Something went wrong, try again later!")
                } else {
                    self.pagerView.reloadData()
                    self.removeEmptyView()
                }
            }
        }
    }
    
    @IBAction func buttonPreviousTapped(_ sender: Any) {
        if self.monthNumber > 1 {
            self.monthNumber -= 1
            self.textFieldMonth.text = Date().getMonthFrom(number: self.monthNumber)
            self.buttonNext.isEnabled = true
        }
        if self.monthNumber == 1 {
            self.buttonPrevious.isEnabled = false
        }
    }
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        if self.monthNumber < maxNumberOfMonths {
            self.monthNumber += 1
            self.textFieldMonth.text = Date().getMonthFrom(number: self.monthNumber)
            self.buttonPrevious.isEnabled = true
        }
        if self.monthNumber == maxNumberOfMonths {
            self.buttonNext.isEnabled = false
        }
    }
    
    func initializeViews() {
        let calendar = Calendar.current
        self.monthNumber = calendar.component(Calendar.Component.month, from: Date())
        self.textFieldMonth.text = Date().getMonthFrom(number: self.monthNumber)
        
        let currentYearString = calendar.component(Calendar.Component.year, from: Date())
        let dateComponents = DateComponents(year: currentYearString, month: self.monthNumber)
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .month, in: .year, for: date)!
        self.maxNumberOfMonths = range.count
    }
    
    func setupPagerView() {
        self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        self.pagerView.register(UINib.init(nibName: CellIdentifiers.BreadOfLifeViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.BreadOfLifeViewCell)
        
        let itemWidth = self.pagerView.frame.size.width*0.8
        let itemHeight = self.pagerView.frame.size.height*0.8
        self.pagerView.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.BreadOfLifeViewCell, at: index) as? BreadOfLifeViewCell {
            
            cell.contentView.layer.shadowRadius = 0
            cell.backgroundColor = Colors.lightGray
            cell.layer.cornerRadius = 30
            
            let breadOfLife = breadOfLifes[index]
            
            if breadOfLife.type?.lowercased() == "quote" {
                if let imgUrl = breadOfLife.img_url {
                    cell.imageViewIcon.kf.setImage(with: URL(string: Services.getMediaUrl() + imgUrl))
                    cell.imageViewIcon.isHidden = false
                }
            } else if breadOfLife.type?.lowercased() == "bible" {
                cell.labelTitle.text = breadOfLife.title
                cell.textViewDescription.text = breadOfLife.description
                cell.labelDate.text = breadOfLife.date
                cell.imageViewIcon.isHidden = true
            }
            
            return cell
        }
        
        return FSPagerViewCell()
    }

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return breadOfLifes.count
    }
    
    func dummyData() {
        breadOfLifes = [
            BreadOfLife.init(title: "2 Chronicles 7:14", desc: "if my people, who are called by my name, will humble themselves and pray and seek my face and turn from their wicked ways, then I will hear from heaven, and I will forgive their sin and will heal their land.", date: "Monday, 5 March 2018"),
            BreadOfLife.init(title: "Proverbs 14:27", desc: "The fear of the LORD is a fountain of life, turning a person from the snares of death.", date: "Tuesday, 6 March 2018"),
            BreadOfLife.init(title: "Psalm 25:9", desc: "He guides the humble in what is right and teaches them his way.", date: "Wednesday, 7 March 2018"),
            BreadOfLife.init(title: "Daniel 10:12", desc: "Then he continued, “Do not be afraid, Daniel. Since the first day that you set your mind to gain understanding and to humble yourself before your God, your words were heard, and I have come in response to them.", date: "Thursday, 8 March 2018"),
            BreadOfLife.init(title: "Ephesians 3:16-21", desc: "I pray that out of his glorious riches he may strengthen you with power through his Spirit in your inner being, 17 so that Christ may dwell in your hearts through faith. And I pray that you, being rooted and established in love, 18 may have power, together with all the Lord’s holy people, to grasp how wide and long and high and deep is the love of Christ, 19 and to know this love that surpasses knowledge—that you may be filled to the measure of all the fullness of God. 20 Now to him who is able to do immeasurably more than all we ask or imagine, according to his power that is at work within us, 21 to him be glory in the church and in Christ Jesus throughout all generations, for ever and ever! Amen.", date: "Friday, 9 March 2018")
        ]
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
