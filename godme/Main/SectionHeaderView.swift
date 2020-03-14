//
//  SectionHeaderView.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/7/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

//protocol SectionHeaderViewProtocol {
////    func 
//}

class SectionHeaderView: UITableViewHeaderFooterView, CollapseSectionHeader {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var indicatorImageView: UIImageView {
        return imageView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage.init(named: "ic_arrow_down-1")?.withRenderingMode(.alwaysOriginal)//.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = .white
        self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
}
