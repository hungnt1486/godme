//
//  MainTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main3TableViewCellProtocol {
    func didCellMain3(index: Int)
}

class Main3TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var delegate: Main3TableViewCellProtocol?
    var listCollaboration: [CollaborationModel] = []
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
        self.collectionView.register(UINib.init(nibName: "Main3CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Main3CollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "DefaultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DefaultCollectionViewCell")
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width*0.6, height: 180)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
}

extension Main3TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listCollaboration.count == 0 {
            return 1
        }
        return listCollaboration.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.listCollaboration.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionViewCell",
            for: indexPath) as! DefaultCollectionViewCell
            cell.lbTitle.text = "Chưa có hợp tác nào"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main3CollectionViewCell",
                                                      for: indexPath) as! Main3CollectionViewCell
        let model = listCollaboration[indexPath.row]
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.images ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbTitle.text = model.title
        cell.lbTime.text = model.description
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.didEvent(index: indexPath.row)
        if self.listCollaboration.count == 0 {
            return
        }
        delegate?.didCellMain3(index: indexPath.row)
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
