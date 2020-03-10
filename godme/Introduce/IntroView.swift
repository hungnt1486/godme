//
//  IntroView.swift
//  texttt
//
//  Created by fcsdev on 3/6/20.
//  Copyright © 2020 fcsdev. All rights reserved.
//

import UIKit

protocol IntroViewProtocol {
    func didStart()
    func didVN()
    func didEnglish()
}

class IntroView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btEnglish: UIButton!
    @IBOutlet weak var btVN: UIButton!
    @IBOutlet weak var btStart: UIButton!
    @IBOutlet weak var vTwo: UIView!
    var delegate:IntroViewProtocol?
    var data: [String: String] = [:]
    
    class func instanceFromNib() ->IntroView{
        return UINib.init(nibName: "IntroView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! IntroView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configIntroView(frameView: CGRect, index: Int = 0) {
        self.setupLanguage()
        self.setupUI()
        self.frame = CGRect(x: ((frameView.size.width)*CGFloat(index)), y: frameView.origin.y, width: frameView.size.width, height: frameView.size.height)
    }
    
    func setupUI(){
        self.vTwo.roundCorners(corners: [.topLeft, .topRight], radius: 50.0)
        self.btStart = Settings.ShareInstance.setupButton(button: self.btStart)
        self.imageView.image = UIImage.init(named: data["imageView"] ?? "")
        self.lbDescription.text = data["description"] ?? ""
        self.lbTitle.text = data["title"] ?? ""
    }
    
    func setupLanguage(){
        self.btStart.setTitle(Settings.ShareInstance.translate(key: "start"), for: .normal)
        self.btVN.setTitle(Settings.ShareInstance.translate(key: "vietnamese"), for: .normal)
        self.btEnglish.setTitle(Settings.ShareInstance.translate(key: "english"), for: .normal)
    }
    
    @IBAction func touchStart(_ sender: Any) {
        delegate?.didStart()
    }
    
    @IBAction func touchVN(_ sender: Any) {
        delegate?.didVN()
    }
    
    @IBAction func touchEnglish(_ sender: Any) {
        delegate?.didEnglish()
    }
}
