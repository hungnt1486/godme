//
//  VMapLeft.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol VMapLeftProtocol {
    func didService()
    func didAuction()
    func didEvent()
}

class VMapLeft: UIView {

    @IBOutlet weak var vSlider: UIView!
    @IBOutlet weak var btService: UIButton!
    @IBOutlet weak var btAuction: UIButton!
    @IBOutlet weak var btEvent: UIButton!
    
    var delegate: VMapLeftProtocol?
    
    class func instanceFromNib() ->VMapLeft{
        return UINib.init(nibName: "VMapLeft", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VMapLeft
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(){
        
    }
    
    func configVMapLeft(frameView: CGRect, index: Int = 1) {
        self.setupUI()
        self.frame = CGRect(x: 0, y: 0, width: frameView.size.width, height: frameView.size.height)
    }
    
    
    @IBAction func touchService(_ sender: Any) {
        delegate?.didService()
    }
    
    @IBAction func touchAuction(_ sender: Any) {
        delegate?.didAuction()
    }
    
    @IBAction func touchEvent(_ sender: Any) {
        delegate?.didEvent()
    }
}
