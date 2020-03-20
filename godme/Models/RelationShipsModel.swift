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

//class RelationShipExpand: BaseModel {
//    var id: Int?
//    var userCategory: String?
//    var fullName: String?
//    var avatar: String?
//    var career: String?
//    var totalStar: Float?
//    var phoneNumber: String?
//    var email: String?
//    var totalBenefited: Int?
//    var address: String?
//
//    required init?(json: JSON) {
//        super.init(json: json)
//        id = json["id"].intValue
//        userCategory = json["userCategory"].stringValue
//        fullName = json["fullName"].stringValue
//        avatar = json["avatar"].stringValue
//        career = json["career"].stringValue
//        totalStar = json["totalStar"].floatValue
//        phoneNumber = json["phoneNumber"].stringValue
//        email = json["email"].stringValue
//        totalBenefited = json["totalBenefited"].intValue
//        address = json["address"].stringValue
//    }
//    "id": 18,
//    "userCategory": "SIGNUP_USER",
//    "fullName": "Be Mong",
//    "avatar": "https://s3.ap-northeast-1.amazonaws.com/godme2019/images%2F1577292740132_gettyimages-911983386-1573497756.jpg",
//    "career": "30",
//    "totalStar": 0,
//    "phoneNumber": "+84376147579",
//    "email": "Saothuytinh15071@gmail.com",
//    "totalBenefited": 0,
//    "address": "A, Phường 02, Quận Tân Bình, Thành phố Hồ Chí Minh, Việt Nam"
//}
