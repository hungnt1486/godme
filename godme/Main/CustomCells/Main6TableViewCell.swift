//
//  MainTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main6TableViewCellProtocol {
    func didCellMain6(index: Int)
}

class Main6TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var delegate: Main6TableViewCellProtocol?
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
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width*0.6, height: 290)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
}

extension Main6TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listBlogs.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if indexPath.section == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main4CollectionViewCell",
                                                      for: indexPath) as! Main4CollectionViewCell
        cell.btJoin.tag = indexPath.row
        cell.delegate = self
        let model = listBlogs[indexPath.row]
        cell.lbTitle.text = model.title
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.image ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
//        cell.lbCity.text = "Địa chỉ: \(model.userInfo?.address ?? "")"
//        cell.lbTitleDetail.text = model.userInfo?.userCategory
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.didEvent(index: indexPath.row)
        delegate?.didCellMain6(index: indexPath.row)
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

extension Main6TableViewCell: Main4CollectionViewCellProtocol{
    func didJoin4(index: Int) {
        print("index join = ", index)
    }
    
    
}
