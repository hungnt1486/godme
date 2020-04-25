//
//  VSearchBar.swift
//  godme
//
//  Created by Lê Hùng on 3/11/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol VSearchBarProtocol {
    func didSearch(_ str: String)
}

class VSearchBar: UIView {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var iconSearch: UIImageView!
    @IBOutlet weak var btSearch: UIButton!
    var delegate: VSearchBarProtocol?
    
    class func instanceFromNib() ->VSearchBar{
        return UINib.init(nibName: "VSearchBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VSearchBar
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configVSearchBar(frameView: CGRect) {
        self.setupUI()
        self.frame = CGRect(x: frameView.origin.x, y: frameView.origin.y, width: frameView.size.width, height: frameView.size.height)
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupBTV(v: self.vContent)
        let tapGesture = UIGestureRecognizer.init(target: self, action: #selector(touchSearch))
        self.iconSearch.isUserInteractionEnabled = true
        self.iconSearch.addGestureRecognizer(tapGesture)
        
        self.tfInput.attributedPlaceholder = NSAttributedString(string: Settings.ShareInstance.translate(key: "label_search"),
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.FlatColor.Gray.BGColor])
    }
    
    @objc func touchSearch(){
        delegate?.didSearch(self.tfInput.text ?? "")
    }
    @IBAction func touchSearchButton(_ sender: Any) {
        delegate?.didSearch(self.tfInput.text ?? "")
    }
    
}
