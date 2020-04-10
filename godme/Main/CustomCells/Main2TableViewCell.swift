//
//  MainTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main2TableViewCellProtocol {
    func didCellMain2(index: Int)
}

class Main2TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var delegate: Main2TableViewCellProtocol?
    var listEvents: [EventModel] = []
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
        self.collectionView.register(UINib.init(nibName: "Main2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Main2CollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "DefaultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DefaultCollectionViewCell")
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width*0.6, height: 290)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
}

extension Main2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.listEvents.count == 0 {
            return 1
        }
        return listEvents.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if listEvents.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionViewCell",
            for: indexPath) as! DefaultCollectionViewCell
            cell.lbTitle.text = "Chưa có sự kiện"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main2CollectionViewCell",
                                                      for: indexPath) as! Main2CollectionViewCell
        cell.btJoin.tag = indexPath.row
        cell.delegate = self
        let model = listEvents[indexPath.row]
        let images = model.images
        let arrImgage = images?.split(separator: ",")
        var linkImg = ""
        if arrImgage!.count > 0 {
            linkImg = String(arrImgage?[0] ?? "")
        }
        cell.imgAvatar.sd_setImage(with: URL.init(string: linkImg), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbCity.text = model.address
        cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
        cell.lbNumberRegister.text = "Số người đã đăng ký: \(model.totalOrder ?? 0)/\(model.maxOrder ?? 0)"
//        cell.lbTitleDetail.text = model.userInfo?.userCategory
        cell.lbTitle.text = model.title
        cell.lbFee.text = "Phí tham dự: \(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            delegate?.didEvent(index: indexPath.row)
        if listEvents.count == 0 {
            return
        }
        delegate?.didCellMain2(index: indexPath.row)
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

extension Main2TableViewCell: Main2CollectionViewCellProtocol{
    func didJoin(index: Int) {
        print("index join = ", index)
    }
    
    
}
