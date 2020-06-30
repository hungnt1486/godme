//
//  SearchBarVoteViewController.swift
//  godme
//
//  Created by Lê Hùng on 6/25/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarVoteViewController: BaseViewController {

    @IBOutlet weak var tbvSearchBarVote: CollapseTableView!
    var listTypeCell: [typeCellServicesInfoBookedDetail] = [.Vote, .Description, .Confirm]
    var cellVote: VoteTableViewCell!
    var intVote = 0
    var modelDetail: UserRegisterReturnModel?
    var modelBaseService = RateBaseServiceParamsModel()
    var listRating: [ListRatingModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        self.tbvSearchBarVote.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvSearchBarVote.openSection(0, animated: true)
        }
        self.showProgressHub()
        self.getListRating()
    }
    
    func setupTableView(){
    
       self.tbvSearchBarVote.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvSearchBarVote.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvSearchBarVote.register(UINib(nibName: "VoteTableViewCell", bundle: nil), forCellReuseIdentifier: "VoteTableViewCell")
        self.tbvSearchBarVote.register(UINib(nibName: "VotesTableViewCell", bundle: nil), forCellReuseIdentifier: "VotesTableViewCell")
        self.tbvSearchBarVote.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
       

        self.tbvSearchBarVote.delegate = self
        self.tbvSearchBarVote.dataSource = self
        self.tbvSearchBarVote.separatorColor = UIColor.clear
        self.tbvSearchBarVote.separatorInset = UIEdgeInsets.zero
        self.tbvSearchBarVote.estimatedRowHeight = 300
        self.tbvSearchBarVote.rowHeight = UITableView.automaticDimension
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvSearchBarVote.reloadData()
        CATransaction.commit()
    }
    
    func rateUser(model: AddNewRateBaseServiceParams){
        UserManager.shareUserManager().rateUser(model: model) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_thank_vote"), vc: self) { [unowned self](str) in
                    self.navigationController?.popViewController(animated: true)
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListRating(){
        UserManager.shareUserManager().getListRating(toUserId: modelDetail?.id ?? 0) { [unowned self](response) in
            switch response {

            case .success(let data):
                self.hideProgressHub()
                self.listRating = data
                self.tbvSearchBarVote.reloadData()
                break
            case .failure(message: let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
            }
        }
    }

}

extension SearchBarVoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listRating.count
        }
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let typeCell = listTypeCell[indexPath.row]
            switch typeCell {
            case .Vote:
                cellVote = tableView.dequeueReusableCell(withIdentifier: "VoteTableViewCell") as? VoteTableViewCell
                cellVote.delegate = self
                return cellVote
            case .Description:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
                cell.delegate = self
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_write_vote")
                return cell
            case .Confirm:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
                cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "label_send_vote"), for: .normal)
                cell.delegate = self
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VotesTableViewCell") as! VotesTableViewCell
            let model = listRating[indexPath.row]
            cell.imgAvatar.sd_setImage(with: URL.init(string: model.reviewers?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.setupStar(index: model.reviewers?.totalStar ?? 0.0)
            cell.lbTitle.text = model.reviewers?.fullName ?? ""
            cell.lbComment.text = model.comment ?? ""
            cell.lbTime.text = "\(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.modifiedOn ?? 0.0))"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        if section == 0 {
            view.lbTitle.text = Settings.ShareInstance.translate(key: "label_view_all_vote")
        }else{
            view.lbTitle.text = Settings.ShareInstance.translate(key: "label_write_vote")
        }
        return view
    }
}

extension SearchBarVoteViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        if intVote == 0 {
            Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_choose_star_for_vote"), vc: self)
            return
        }
        self.showProgressHub()
        var model = AddNewRateBaseServiceParams()
        model.point = intVote
        model.sellerId = modelDetail?.id ?? 0
        model.comment = self.modelBaseService.comment
        self.rateUser(model: model)
        
    }
}

extension SearchBarVoteViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.modelBaseService.comment = string ?? ""
    }
}

extension SearchBarVoteViewController: VoteTableViewCellProtocol{
    func didImg1() {
        cellVote.setupStar(index: 1.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_dissatisfaction")
        intVote = 1
    }
    
    func didImg2() {
        cellVote.setupStar(index: 2.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_unsatisfied")
        intVote = 2
    }
    
    func didImg3() {
        cellVote.setupStar(index: 3.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_normal")
        intVote = 3
    }
    
    func didImg4() {
        cellVote.setupStar(index: 4.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_satisfied")
        intVote = 4
    }
    
    func didImg5() {
        cellVote.setupStar(index: 5.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_very_satisfied")
        intVote = 5
    }
}
