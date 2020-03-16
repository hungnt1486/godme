//
//  UserModel.swift
//  godme
//
//  Created by fcsdev on 3/16/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserRegisterReturnModel: BaseModel {
    var fullName: String?
    var userCategory: String?
    var email: String?
    var gender: String?
    var nationCode: String?
    var nationName: String?
    var provinceCode: String?
    var provinceName: String?
    var districtCode: String?
    var districtName: String?
    var wardCode: String?
    var wardName: String?
    var address: String?
    var career: String?
    var education: String?
    var referralCode: String?
    var limitReferralCode: Int?
    var userCode: String?
    var avatar: String?
    var position: String?
    var experience: String?
    var idNumber: Int?
    var phoneNumber: String?
    var dob: String?
    var userInfo: String?
    var id: Int?
    var createdOn: String?
    var createdBy: String?
    var modifiedOn: String?
    var createdByUserId: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        fullName = json["fullName"].stringValue
        userCategory = json["userCategory"].stringValue
        email = json["email"].stringValue
        gender = json["gender"].stringValue
        nationCode = json["nationCode"].stringValue
        nationName = json["nationName"].stringValue
        provinceCode = json["provinceCode"].stringValue
        provinceName = json["provinceName"].stringValue
        districtCode = json["districtCode"].stringValue
        districtName = json["districtName"].stringValue
        wardCode = json["wardCode"].stringValue
        wardName = json["wardName"].stringValue
        address = json["address"].stringValue
        career = json["career"].stringValue
        education = json["education"].stringValue
        referralCode = json["referralCode"].stringValue
        limitReferralCode = json["limitReferralCode"].intValue
        userCode = json["userCode"].stringValue
        avatar = json["avatar"].stringValue
        position = json["position"].stringValue
        experience = json["experience"].stringValue
        idNumber = json["idNumber"].intValue
        phoneNumber = json["phoneNumber"].stringValue
        dob = json["dob"].stringValue
        userInfo = json["userInfo"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].stringValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].stringValue
        createdByUserId = json["createdByUserId"].stringValue
    }
}

class UserLoginReturnModel: BaseModel{
    var access_token: String?
    var fullName: String?
    var userId: Int?
    var permissions: [String]?
    
    required init?(json: JSON) {
        super.init(json: json)
        access_token = json["access_token"].stringValue
        fullName = json["fullName"].stringValue
        userId = json["userId"].intValue
        permissions = json["permissions"].arrayObject as? [String]
    }
}

//class Permissions: BaseModel{
//
//}

//"result": {
//    "access_token": "cvgnroh1qd9i507fndb4mhtv6le51l5l",
//    "permissions": [
//        "ROLE_ALLOW_ACCESS_SYSTEM",
//        "ROLE_USER"
//    ],
//    "fullName": "test006",
//    "userName": "0909301378",
//    "userId": 55
//}
