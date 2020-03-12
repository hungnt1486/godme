//
//  SearchBarServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarServiceViewController: BaseViewController {
    @IBOutlet weak var tbvServices: CollapseTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        
        self.tbvServices.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvServices.openSection(0, animated: true)
        }
    }
    
    func setupTableView(){
        self.tbvServices.register(UINib(nibName: "SearchBarRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarRelationShipTableViewCell")

        self.tbvServices.delegate = self
        self.tbvServices.dataSource = self
        self.tbvServices.separatorColor = UIColor.clear
        self.tbvServices.separatorInset = UIEdgeInsets.zero
        self.tbvServices.estimatedRowHeight = 300
        self.tbvServices.rowHeight = UITableView.automaticDimension
        
        self.tbvServices.tableFooterView = UIView(frame: .zero)
        self.tbvServices.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvServices.reloadData()
        CATransaction.commit()
    }

}

extension SearchBarServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarRelationShipTableViewCell") as! SearchBarRelationShipTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        return view
        
//        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) else {
//            let view = Bundle.main.loadNibNamed(SectionHeaderView.reuseIdentifier, owner: self, options: nil)?.first as? SectionHeaderView
//            return view
//        }
//        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
}
