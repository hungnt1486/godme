//
//  BookServiceTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol BookServiceTableViewCellProtocol {
    func didBookService()
}

class BookServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var btBookService: UIButton!
    var delegate: BookServiceTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.btBookService = Settings.ShareInstance.setupButton(button: self.btBookService)
    }
    
    @IBAction func touchBookService(_ sender: Any) {
        delegate?.didBookService()
    }
    
}
