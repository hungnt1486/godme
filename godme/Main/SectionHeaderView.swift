//
//  SectionHeaderView.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/7/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, CollapseSectionHeader {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var indicatorImageView: UIImageView {
        return imageView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imageView.image = .withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
    }
}
