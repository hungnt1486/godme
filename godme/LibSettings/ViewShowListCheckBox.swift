//
//  ViewDatePicker.swift
//  pCare
//
//  Created by Lê Hùng on 11/13/18.
//  Copyright © 2018 fcsdev. All rights reserved.
//

import UIKit

protocol ViewShowListCheckBoxProtocol {
    func tapDone(_ list: [Int])
    func tapCancel()
    func tapGesture()
}

class ViewShowListCheckBox: UIView {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vPopup: UIView!
    @IBOutlet weak var tbvListCheckBox: UITableView!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var btDone: UIButton!
    
    
    var strDateTime: String?
    
    var listIndex: [Int] = []
    
    
    var delegate: ViewShowListCheckBoxProtocol?
    
    //MARK: - Setup
    class func instanceFromNib() -> ViewShowListCheckBox {
        return UINib(nibName: "ViewShowListCheckBox", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ViewShowListCheckBox
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        DispatchQueue.main.async {
//            self.configUI()
////            self.configFrame()
//        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGesture))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapGesture() {
        delegate?.tapGesture()
    }
    
    func setupTableView(){
        self.tbvListCheckBox.register(UINib(nibName: "CheckBoxTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckBoxTableViewCell")

        self.tbvListCheckBox.delegate = self
        self.tbvListCheckBox.dataSource = self
        self.tbvListCheckBox.separatorColor = UIColor.clear
        self.tbvListCheckBox.separatorInset = UIEdgeInsets.zero
        self.tbvListCheckBox.estimatedRowHeight = 300
        self.tbvListCheckBox.rowHeight = UITableView.automaticDimension
    }
    
    func configUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.btCancel = Settings.ShareInstance.setupButton(button: self.btCancel)
        self.btCancel.setBorder()
        self.btDone = Settings.ShareInstance.setupButton(button: self.btDone)
        
        vPopup.layer.cornerRadius = 10.0
        vPopup.layer.borderWidth = 1.0
        vPopup.backgroundColor = UIColor.FlatColor.Gray.BGColor
        vPopup.layer.borderColor = UIColor.FlatColor.Gray.TextColor.withAlphaComponent(0.5).cgColor
        vPopup.dropShadow()
//
//        viewFee.layer.borderWidth = 1.0
//        viewFee.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
//        viewCode.layer.borderWidth = 1.0
//        viewCode.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
//
//        btOrder.layer.cornerRadius = self.btOrder.frame.size.height/2
//        btOrder.layer.borderWidth = 1.0
//        btOrder.layer.borderColor = UIColor(hexString: Color.mainColor).cgColor
//
//        tfCode.layer.cornerRadius = tfCode.frame.size.height/2
//        tfCode.layer.borderWidth = 1.0
//        tfCode.layer.borderColor = UIColor.black.cgColor
//        tfCode.layer.masksToBounds = true
    }
    
    func configFrame() {
        self.configUI()
        self.setupTableView()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    @IBAction func touchCancel(_ sender: Any) {
        delegate?.tapCancel()
    }
        
    @IBAction func touchDone(_ sender: Any) {
        delegate?.tapDone(self.listIndex)
    }
}

extension ViewShowListCheckBox: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BaseViewController.listGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell") as! CheckBoxTableViewCell
        let model = BaseViewController.listGroup[indexPath.row]
        cell.delegate = self
        cell.bt1.tag = indexPath.row
        cell.img1.tag = indexPath.row
        cell.lbTitle1.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewShowListCheckBox: CheckBoxTableViewCellProtocol{
    func didImg1(_ index: Int) {
        let cellCheckBox = self.tbvListCheckBox.cellForRow(at: IndexPath.init(item: index, section: 0)) as? CheckBoxTableViewCell
        if cellCheckBox?.img1!.tag == index {
            if cellCheckBox?.img1.image?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_uncheck")?.jpegData(compressionQuality: 0.5) {
                cellCheckBox?.img1.image = UIImage.init(named: "ic_uncheck")
                if self.listIndex.count > 0 {
                    self.listIndex.removeAll{$0 == index}
                }
                print(self.listIndex)
            }else{
                cellCheckBox?.img1.image = UIImage.init(named: "ic_checked")
                self.listIndex.append(index)
            }
        }
    }
}
