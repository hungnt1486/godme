//
//  VSearchBar.swift
//  godme
//
//  Created by Lê Hùng on 3/11/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol VSearchBarMapProtocol {
    func didSearchMap()
}

class VSearchBarMap: UIView {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tfInputText: UITextField!
    var delegate: VSearchBarMapProtocol?
    
    class func instanceFromNib() ->VSearchBarMap{
        return UINib.init(nibName: "VSearchBarMap", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VSearchBarMap
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configVSearchBar(frameView: CGRect) {
        self.setupUI()
        self.frame = CGRect(x: frameView.origin.x, y: frameView.origin.y, width: frameView.size.width, height: frameView.size.height)
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        self.tfInputText = Settings.ShareInstance.setupTextField(textField: self.tfInputText, isLeftView: true)
    }
    @IBAction func touchSearch(_ sender: Any) {
        delegate?.didSearchMap()
    }
    
}
