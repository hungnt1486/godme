//
//  RelationShipsModel.swift
//  godme
//
//  Created by Lê Hùng on 3/19/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class RelationShipsModel: BaseModel {
    var address: String?
    var avatar: String?
    var career: String?
    var datesLeft: Int?
    var email: String?
    var fullName: String?
    var id: Int?
    var phoneNumber: String?
    var totalBenefited: Int?
    var totalStar: Float?
    var userCategory: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        address = json["address"].stringValue
        avatar = json["avatar"].stringValue
        career = json["career"].stringValue
        datesLeft = json["datesLeft"].intValue
        email = json["email"].stringValue
        fullName = json["fullName"].stringValue
        id = json["id"].intValue
        phoneNumber = json["phoneNumber"].stringValue
        totalBenefited = json["totalBenefited"].intValue
        totalStar = json["totalStar"].floatValue
        userCategory = json["userCategory"].stringValue
    }
}

class GroupRelationShipModel: BaseModel {
    var name: String?
    var status: String?
    var userIds: String?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var listUserInfo: [userInfoModel]?
    required init?(json: JSON) {
        super.init(json: json)
        name = json["name"].stringValue
        status = json["status"].stringValue
        userIds = json["userIds"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        if let userInfo = json["listUserInfo"].array {
            listUserInfo = [userInfoModel]()
            for item in userInfo {
                listUserInfo?.append(userInfoModel.init(json: item)!)
            }
        }
    }
}
