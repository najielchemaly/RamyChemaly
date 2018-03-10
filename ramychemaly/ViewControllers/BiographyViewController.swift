//
//  BiographyViewController.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/7/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class BiographyViewController: BaseViewController, FSPagerViewDataSource, FSPagerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var labelBar: UILabel!
    @IBOutlet weak var barLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var barWidthConstraint: NSLayoutConstraint!
    
    var biographies: [Biography] = [Biography]()
    
    let itemSpacing = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dummyData()
        self.setupCollectionView()
        self.setupCollectViewLayout()
        self.setupPagerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toolbarView.labelTitle.text = "BIOGRAPHY"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: CellIdentifiers.BioCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.BioCollectionViewCell)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return biographies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.BioCollectionViewCell, for: indexPath) as? BioCollectionViewCell {
            
            let biography = biographies[indexPath.row]
            if let imageThumb = biography.img_thumb {
                cell.imageViewIcon.kf.setImage(with: URL(string: imageThumb))
            }
            
            cell.labelTitle.text = biography.title_short
            
            setDummyImage(imageView: cell.imageViewIcon, index: indexPath.row)
            
            cell.layer.cornerRadius = 10
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    var selectedIndex = 0
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if pagerView.currentIndex != selectedIndex {
            pagerView.scrollToItem(at: selectedIndex, animated: true)
        }
    }
    
    func setupCollectViewLayout() {
        if let flow = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let screenWidth = self.collectionView.frame.size.width
            let itemsCount = self.biographies.count
            let itemWidth = ((screenWidth+CGFloat(itemSpacing))-CGFloat((itemsCount*itemSpacing)))/CGFloat(itemsCount)
            flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            flow.itemSize = CGSize(width: itemWidth, height: itemWidth)
            flow.minimumLineSpacing = CGFloat(itemSpacing)
            flow.minimumInteritemSpacing = CGFloat(itemSpacing)
            
            barWidthConstraint.constant = itemWidth
        }
    }
    
    func setupPagerView() {
        self.pagerView.register(UINib.init(nibName: CellIdentifiers.BioPagerViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.BioPagerViewCell)
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        if let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.BioPagerViewCell, at: index) as? BioPagerViewCell {
            
            let biography = biographies[index]
            if let imageUrl = biography.img_url {
                cell.imageViewBio.kf.setImage(with: URL(string: imageUrl))
            }

            cell.labelTitle.text = biography.title_long
            cell.textViewDescription.text = biography.description
            
            cell.contentView.layer.shadowRadius = 0
            
            setDummyImage(imageView: cell.imageViewBio, index: index)
            
            return cell
        }
        
        return FSPagerViewCell()
    }
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let index = pagerView.currentIndex
        updateBarXPosition(index: index)
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return biographies.count
    }
    
    func updateBarXPosition(index: Int) {
        DispatchQueue.main.async {
            let itemWidth = Int(self.barWidthConstraint.constant)
            let barX = ((self.itemSpacing*index+1)+(index*itemWidth)+self.itemSpacing)
            self.barLeadingConstraint.constant = CGFloat(barX)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func dummyData() {
        var biography = Biography()
        biography.title_short = "Birth"
        biography.title_long = "Ramy's Birth"
        biography.img_thumb = ""
        biography.img_url = ""
        biography.description = "Our beloved son, brother, friend and talented Star was born on April 21st  1987 in a small town called Shaileh, to be the eldest among his 2 brothers Naji & Chady. \nRamy whom the name means loving, was a loving & beloved person in his family and between his friends. \nHe showed from the beginning a remarkable talent and a passion for the music in general and singing in particular."
        biographies.append(biography)
        
        biography = Biography()
        biography.title_short = "Spirit"
        biography.title_long = "Ramy's Spirituality"
        biography.img_thumb = ""
        biography.img_url = ""
        biography.description = "He joined Ste Therese Choir since he was 8 years old, becoming the youngest solo singer by then, with his unusual & unique voice. \nRamy spiritual life was grown with his commitment in the choir, as well being a member in the MAM (movement apostolic marital), where he became a dynamic member known by his devotion for the well being of the team and his hilarious humor of sense."
        biographies.append(biography)
        
        biography = Biography()
        biography.title_short = "Grief"
        biography.title_long = "Ramy's Grief"
        biography.img_thumb = ""
        biography.img_url = ""
        biography.description = "Ramy experienced a big loss in 2002, when his father Kamil passed away at the age of 44 years. \nIt was a tremendous loss especially to an employed wife and mother of 3 boys. \nThe family couldn’t recover from this bad incident without God’s help and Ste Therese blessings that Ramy used to serve her church always."
        biographies.append(biography)
        
        biography = Biography()
        biography.title_short = "Starac"
        biography.title_long = "@ Staracademy"
        biography.img_thumb = ""
        biography.img_url = ""
        biography.description = "Ramy’s biggest dream other then getting his bachelor degree in agro-alimentary, was to become a professional and famous singer and being able to help his family. \nIn 2010, he was accepted as candidate in Star Academy 7 where he had the chance to sing with a well known singers in arab world such as wadih safi & many others. \nRamy was one of the best & most popular students stayed in the academy, the only Lebanese candidate, until the prime before the finals."
        biographies.append(biography)
        
        biography = Biography()
        biography.title_short = "Eternal"
        biography.title_long = "Ramy's Eternal Life"
        biography.img_thumb = ""
        biography.img_url = ""
        biography.description = "On the day of 8th July 2010, Ramy passed away in a car crash during his first trip outside Lebanon to Cairo. \nHis death came as a shocking news in the arab world & still after almost " + getYearsFrom(yearString: "2010") + " years. \nRamy our beloved son, brother, friend and shining star on the earth & in the sky, we will always love you.. \n\n..Until We Meet Again.."
        biographies.append(biography)
    }
    
    func setDummyImage(imageView: UIImageView, index: Int) {
        switch index {
        case 0:
            imageView.image = #imageLiteral(resourceName: "ramy1")
            break
        case 1:
            imageView.image = #imageLiteral(resourceName: "ramy2")
            break
        case 2:
            imageView.image = #imageLiteral(resourceName: "ramy3")
            break
        case 3:
            imageView.image = #imageLiteral(resourceName: "ramy4")
            break
        case 4:
            imageView.image = #imageLiteral(resourceName: "ramy5")
            break
        default:
            break
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
