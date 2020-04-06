//
//  EditProfileViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/6/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellEditProfile: Int{
    case Avatar = 0
    case FullName = 1
    case Gender = 2
    case Education = 3
    case Position = 4
    case SocialSecurity = 5
    case Job = 6
    case DOB = 7
    case National = 8
    case City = 9
    case District = 10
    case Ward = 11
    case Address = 12
    case Email = 13
    case Experience = 14
    case Intro = 15
    case Code = 16
    case RealText = 17
    case Confirm = 18
}

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var tbvEditProfile: UITableView!
    var listTypeCell: [typeCellEditProfile] = [.Avatar, .FullName, .Gender, .Education, .Position, .SocialSecurity, .Job, .DOB, .National, .City, .District, .Ward, .Address, .Email, .Experience, .Intro, .Code, .RealText, .Confirm]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableview()
    }
    
    func setupUI(){
        self.navigationItem.title = "Cập nhật thông tin"
    }
    
    func setupTableview(){
        self.tbvEditProfile.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "AvatarTableViewCell", bundle: nil), forCellReuseIdentifier: "AvatarTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "TypeCarTableViewCell", bundle: nil), forCellReuseIdentifier: "TypeCarTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvEditProfile.delegate = self
        self.tbvEditProfile.dataSource = self
        self.tbvEditProfile.separatorColor = UIColor.clear
        self.tbvEditProfile.separatorInset = UIEdgeInsets.zero
        self.tbvEditProfile.allowsSelection = false
        self.tbvEditProfile.estimatedRowHeight = 100
        self.tbvEditProfile.rowHeight = UITableView.automaticDimension
    }
    
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .Avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarTableViewCell") as! AvatarTableViewCell
//            cell.tfInput.tag = indexPath.row
            return cell
        case .FullName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .Gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .Education:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .Position:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .SocialSecurity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .DOB:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .National:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .City:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .District:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .Ward:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTypeCar.tag = indexPath.row
            return cell
        case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .Experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            return cell
        case .Intro:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            return cell
        case .Code:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            return cell
        case .RealText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            return cell
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            return cell
        }
    }
    
    
}
