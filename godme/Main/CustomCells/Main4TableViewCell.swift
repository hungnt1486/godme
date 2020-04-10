//
//  MainTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main4TableViewCellProtocol {
    func didCellMain4(index: Int)
}

class Main4TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var delegate: Main4TableViewCellProtocol?
    var listBlogs: [BlogModel] = []
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
        self.collectionView.register(UINib.init(nibName: "Main4CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Main4CollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "DefaultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DefaultCollectionViewCell")
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width*0.6, height: 180)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
}

extension Main4TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listBlogs.count == 0 {
            return 1
        }
        return listBlogs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.listBlogs.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionViewCell",
            for: indexPath) as! DefaultCollectionViewCell
            cell.lbTitle.text = "Chưa có quỹ từ thiện"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main4CollectionViewCell",
                                                      for: indexPath) as! Main4CollectionViewCell
        let model = listBlogs[indexPath.row]
        cell.lbTitle.text = model.title
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.image ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbTime.text = model.description
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.didEvent(index: indexPath.row)
        delegate?.didCellMain4(index: indexPath.row)
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
