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
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var totalStar: Float?
    var isConnected: Int?
    var amountConnect: String?
    
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
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        totalStar = json["totalStar"].floatValue
        isConnected = json["isConnected"].intValue
        amountConnect = json["amountConnect"].stringValue
    }
}

class UserProfileParamsModel {
    var fullName = ""
    var userCategory = ""
    var email = ""
    var gender = ""
    var nationCode = ""
    var nationName = ""
    var provinceCode = ""
    var provinceName = ""
    var districtCode = ""
    var districtName = ""
    var wardCode = ""
    var wardName = ""
    var address = ""
    var career = ""
    var education = ""
    var referralCode = ""
    var limitReferralCode = 0
    var userCode = ""
    var avatar = ""
    var position = ""
    var experience = ""
    var idNumber = 0
    var phoneNumber = ""
    var dob = ""
    var userInfo = ""
    var id = 0
    var createdOn = 0.0
    var createdBy = ""
    var modifiedOn = 0.0
    var createdByUserId = 0
    var totalStar = 0.0
    var isConnected = 0
    var amountConnect = ""
}

struct AddNewUserProfileParams {
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
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var totalStar: Float?
    var isConnected: Int?
    var amountConnect: String?
}

class UserLoginReturnModel: BaseModel{
    var access_token: String?
    var fullName: String?
    var userId: Int?
    var userName: String?
    var permissions: [String]?
    var isFirstLogin: Bool?
    
    required init?(json: JSON) {
        super.init(json: json)
        access_token = json["access_token"].stringValue
        fullName = json["fullName"].stringValue
        userId = json["userId"].intValue
        userName = json["userName"].stringValue
        permissions = json["permissions"].arrayObject as? [String]
        isFirstLogin = json["isFirstLogin"].boolValue
    }
}

struct UserLogin {
    var access_token: String?
    var fullName: String?
    var userId: Int?
    var userName: String?
    var permissions: [String]?
    var isFirstLogin: Bool?
    
}

class JobModel: BaseModel {
    var name: String?
    var code: String?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    required init?(json: JSON) {
        super.init(json: json)
        name = json["name"].stringValue
        code = json["code"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        
    }
}

class MapModel: BaseModel {
    var address: String?
    var amount: Float?
    var distance: Float?
    var id: Int?
    var images: String?
    var latitude: Double?
    var longitude: Double?
    var serviceType: String?
    var title: String?
    required init?(json: JSON) {
        super.init(json: json)
        address = json["address"].stringValue
        amount = json["amount"].floatValue
        distance = json["distance"].floatValue
        id = json["id"].intValue
        images = json["images"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        serviceType = json["serviceType"].stringValue
        title = json["title"].stringValue
    }
}

class GenderModel: BaseModel {
    var Id: String?
    var Name: String?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        Id = json["Id"].stringValue
        Name = json["Name"].stringValue
    }
}

class MyWalletModel: BaseModel {
    var amount: String?
    var accountName: String?
    var userCode: String?
    var userId: Int?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    required init?(json: JSON) {
        super.init(json: json)
        amount = json["amount"].stringValue
        accountName = json["accountName"].stringValue
        userCode = json["userCode"].stringValue
        userId = json["userId"].intValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
    }
}

class TransactionModel: BaseModel {
    var amount: String?
    var status: String?
    var transactionType: String?
    var description: String?
    var bankName: String?
    var branchName: String?
    var accountName: String?
    var userName: String?
    var userId: Int?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var userInfo: userInfoModel?
    required init?(json: JSON) {
        super.init(json: json)
        amount = json["amount"].stringValue
        status = json["status"].stringValue
        transactionType = json["transactionType"].stringValue
        description = json["description"].stringValue
        bankName = json["bankName"].stringValue
        branchName = json["branchName"].stringValue
        accountName = json["accountName"].stringValue
        userName = json["userName"].stringValue
        userId = json["userId"].intValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        userInfo = userInfoModel.init(json: json["userInfo"])
    }
}

class HistoryModel: BaseModel {
    var historyInWeek: [HistorySubModel]?
    var historyInMonth: [HistorySubModel]?
    required init?(json: JSON) {
        super.init(json: json)
        if let listInWeek = json["historyInWeek"].array {
            historyInWeek = [HistorySubModel]()
            for item in listInWeek {
                historyInWeek?.append(HistorySubModel(json: item)!)
            }
        }
        if let listInMonth = json["historyInMonth"].array {
            historyInMonth = [HistorySubModel]()
            for item in listInMonth {
                historyInMonth?.append(HistorySubModel(json: item)!)
            }
        }
    }
}

class HistorySubModel: BaseModel {
    var serviceType: String?
    var totalAmount: String?
    required init?(json: JSON) {
        super.init(json: json)
        serviceType = json["serviceType"].stringValue
        totalAmount = json["totalAmount"].stringValue
    }
}

struct changePasswordParams {
    var username: String?
    var password: String?
    var newPassword: String?
}

class ChangePasswordParamsModel{
    var oldPassword = ""
    var username = ""
    var newPassword = ""
    var confirmPassword = ""
}

class ForgotPasswordParamsModel{
    var username = ""
    var newPassword = ""
    var confirmPassword = ""
    var codeOTP = ""
}

struct forgotPasswordParams {
    var username: String?
    var codeOTP: String?
    var newPassword: String?
}

struct userSearchParams {
    var keyword: String?
    var fullName: String?
    var gender: String?
    var nationCode: String?
    var education: String?
    var career: String?
    var provinceCode: String?
    var districtCode: String?
    var wardCode: String?
    var page: Int?
    var pageSize: Int?
}

class userSearchParamsModel {
    var keyword = ""
    var fullName = ""
    var gender = ""
    var nationCode = ""
    var education = ""
    var career = ""
    var provinceCode = ""
    var districtCode = ""
    var wardCode = ""
    var page = 1
    var pageSize = 10
}

class RegisterParamsModel{
    var username = ""
    var password = ""
    var passwordConfirm = ""
    var fullName = ""
    var email = ""
    var gender = ""
    var nationCode = ""
    var nationName = ""
    var provinceCode = ""
    var provinceName = ""
    var districtCode = ""
    var districtName = ""
    var wardCode = ""
    var wardName = ""
    var address = ""
    var career = ""
    var dob = ""
    var education = ""
    var codeOTP = ""
    var referralCode = ""
}

struct AddNewRegisterParams {
    var username: String?
    var password: String?
    var fullName: String?
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
    var dob: String?
    var education: String?
    var codeOTP: String?
    var referralCode: String?
}

// notifications

class NotificationModel: BaseModel {
    var createdBy: String?
    var createdByUserId: Int?
    var createdOn: Double?
    var description: String?
    var id: Int?
    var images: String?
    var modifiedOn: Double?
    var notifyType: String?
    var status: String?
    var title: String?
    var toUserIds: Int?
    
    required init?(json: JSON) {
        super.init(json: json)
        createdBy = json["createdBy"].stringValue
        createdByUserId = json["createdByUserId"].intValue
        createdOn = json["createdOn"].doubleValue
        description = json["description"].stringValue
        id = json["id"].intValue
        images = json["images"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        notifyType = json["notifyType"].stringValue
        status = json["status"].stringValue
        title = json["title"].stringValue
        toUserIds = json["toUserIds"].intValue
    }
}
