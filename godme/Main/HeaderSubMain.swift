//
//  HeaderSubMain.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol HeaderSubMainProtocol {
    func didMore(index: Int)
}

class HeaderSubMain: UITableViewHeaderFooterView {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btMore: UIButton!
    var delegate: HeaderSubMainProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
    }
    
    @IBAction func touchMore(_ sender: Any) {
        delegate?.didMore(index: self.btMore.tag)
    }
    
}
