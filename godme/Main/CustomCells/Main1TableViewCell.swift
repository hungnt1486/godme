//
//  MainTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main1TableViewCellProtocol {
    func didCellMain1(index: Int)
}

class Main1TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var delegate: Main1TableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setupUI()
        self.setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
    }
    
    override func layoutSubviews(){
        
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "Main1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Main1CollectionViewCell")
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width*0.8, height: 130)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
}

extension Main1TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main1CollectionViewCell",
                                                          for: indexPath) as! Main1CollectionViewCell
//            let modelAds = arrBanner[indexPath.row]
//            cell.imgAds.sd_setImage(with: URL.init(string: modelAds.Photos ?? ""), placeholderImage: UIImage.init(named: "ic_ads_default"), options: .lowPriority) { (img, error, nil, url) in
//                if error == nil {
//                    cell.imgAds.image = img
//                }
//            }
    //        let dict = arr[indexPath.row] as NSDictionary
    //        cell.icon.image = UIImage.init(named: dict.object(forKey: "icon") as! String)
    //        cell.lbTitle.text = dict.object(forKey: "title") as? String
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.didEvent(index: indexPath.row)
            delegate?.didCellMain1(index: indexPath.row)
        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            if isLoadMore! {
//                if indexPath.row == arrBanner.count - 3 {
//                    currentPage! = currentPage! + 1
//    //                self.getListTransportByUser(Skip: self.currentPage*self.pageSize, Take: self.pageSize)
//                    delegate?.didLoadMore(currentPage: currentPage!)
//                }
//            }
        }
}
