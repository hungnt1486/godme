//
//  BaseServiceModel.swift
//  godme
//
//  Created by fcsdev on 3/19/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseServiceModel: BaseModel {
    
    var dateTime1: Double?
    var dateTime2: Double?
    var dateTime3: Double?
    var dateTime4: Double?
    var dateTime5: Double?
    var dateTime6: Double?
    var dateTime7: Double?
    var status: String?
    var title: String?
    var address: String?
    var description: String?
    var language: String?
    var amount: String?
    var images: String?
    var latitude: Double?
    var longitude: Double?
    var totalOrder: Int?
    var totalOrderPending: Int?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var isRelationshipWithSeller: Bool?
    var userInfo: userInfoModel?
    
    required init?(json: JSON) {
        super.init(json: json)
        dateTime1 = json["dateTime1"].doubleValue
        dateTime2 = json["dateTime2"].doubleValue
        dateTime3 = json["dateTime3"].doubleValue
        dateTime4 = json["dateTime4"].doubleValue
        dateTime5 = json["dateTime5"].doubleValue
        dateTime6 = json["dateTime6"].doubleValue
        dateTime7 = json["dateTime7"].doubleValue
        status = json["status"].stringValue
        title = json["title"].stringValue
        address = json["address"].stringValue
        description = json["description"].stringValue
        language = json["language"].stringValue
        amount = json["amount"].stringValue
        images = json["images"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        totalOrder = json["totalOrder"].intValue
        totalOrderPending = json["totalOrderPending"].intValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        isRelationshipWithSeller = json["isRelationshipWithSeller"].boolValue
        userInfo = userInfoModel(json: json["userInfo"])
    }
    
}


class userInfoModel: BaseModel {
    var id: Int?
    var userCategory: String?
    var fullName: String?
    var avatar: String?
    var career: String?
    var totalStar: Float?
    var address: String?
    var userInfo: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        id = json["id"].intValue
        userCategory = json["userCategory"].stringValue
        fullName = json["fullName"].stringValue
        career = json["career"].stringValue
        totalStar = json["totalStar"].floatValue
        address = json["address"].stringValue
        avatar = json["avatar"].stringValue
        userInfo = json["userInfo"].stringValue
    }
}

class buyerInfoModel: BaseModel{
    var id: Int?
    var userCategory: String?
    var fullName: String?
    var avatar: String?
    var career: String?
    var totalStar: Float?
    var address: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        id = json["id"].intValue
        userCategory = json["userCategory"].stringValue
        fullName = json["fullName"].stringValue
        avatar = json["avatar"].stringValue
        career = json["career"].stringValue
        totalStar = json["totalStar"].floatValue
        address = json["address"].stringValue
    }
}

class sellerInfoModel: BaseModel{
    var id: Int?
    var userCategory: String?
    var fullName: String?
    var avatar: String?
    var career: String?
    var totalStar: Float?
    var address: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        id = json["id"].intValue
        userCategory = json["userCategory"].stringValue
        fullName = json["fullName"].stringValue
        avatar = json["avatar"].stringValue
        career = json["career"].stringValue
        totalStar = json["totalStar"].floatValue
        address = json["address"].stringValue
    }
}

class BaseServiceInfoBookedModel: BaseModel {
    var status: String?
    var serviceId: Int?
    var dateTime: Double?
    var sellerId: Int?
    var buyerId: Int?
    var amount: String?
    var serviceTitle: String?
    var isRated: Bool?
    var affiliateUserId: String?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var createdByUserId: Int?
    var buyerInfo: buyerInfoModel?
    var sellerInfo: sellerInfoModel?
    required init?(json: JSON) {
        super.init(json: json)
        status = json["status"].stringValue
        serviceId = json["serviceId"].intValue
        dateTime = json["dateTime"].doubleValue
        sellerId = json["sellerId"].intValue
        buyerId = json["buyerId"].intValue
        amount = json["amount"].stringValue
        serviceTitle = json["serviceTitle"].stringValue
        isRated = json["isRated"].boolValue
        affiliateUserId = json["affiliateUserId"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        createdByUserId = json["createdByUserId"].intValue
        buyerInfo = buyerInfoModel.init(json: json["buyerInfo"])
        sellerInfo = sellerInfoModel.init(json: json["sellerInfo"])
    }
}

class BasicServiceModel {
    var title = ""
    var dateTime1 = 0.0
    var dateTime2 = 0.0
    var dateTime3 = 0.0
    var dateTime4 = 0.0
    var dateTime5 = 0.0
    var dateTime6 = 0.0
    var dateTime7 = 0.0
    var address = ""
    var latitude = 0.0
    var longitude = 0.0
    var description = ""
    var language = ""
    var amount = ""
    var images = ""
}

class EventServiceParamsModel{
    var title = ""
    var startTime = 0.0
    var endTime = 0.0
    var address = ""
    var latitude = 0.0
    var longitude = 0.0
    var description = ""
    var language = ""
    var amount = ""
    var images = ""
    var maxOrder = ""
}

class AuctionServiceParamsModel{
    var title = ""
    var startTime = 0.0
    var endTime = 0.0
    var address = ""
    var latitude = 0.0
    var longitude = 0.0
    var description = ""
    var language = ""
    var amount = ""
    var images = ""
    var priceStep = ""
}

class CollaborationServiceParamsModel {
    var title = ""
    var description = ""
    var content = ""
    var fullName = ""
    var email = ""
    var phoneNumber = ""
    var images = ""
}

struct AddNewBaseServiceParams {
    var title: String?
    var dateTime1: Double?
    var dateTime2: Double?
    var dateTime3: Double?
    var dateTime4: Double?
    var dateTime5: Double?
    var dateTime6: Double?
    var dateTime7: Double?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var description: String?
    var language: String?
    var amount: String?
    var images: String?
}

struct AddNewConfirmBasicServiceParams {
    var serviceId: Int?
    var sellerId: Int?
    var buyerId: Int?
    var amount: Int?
    var dateTime: Double?
}

class HelpServiceParamsModel {
    var title = ""
    var description = ""
    var images = ""
}

struct AddNewHelpServiceParams {
    var title: String?
    var description: String?
    var images: String?
}

class PushNotificationServiceParamsModel {
    var title = ""
    var description = ""
    var images = ""
    var target: [String] = []
    var relationship:[Int] = []
}

struct AddNewPushNotificationServiceParams {
    var title: String?
    var description: String?
    var images: String?
    var target: [String]?
    var relationship: [Int]?
}

struct AddNewFindMapParams {
    var keySearch: String?
    var centerLat: Double?
    var centerLong: Double?
    var radius: Int?
    var services: [String]?
}

class RateBaseServiceParamsModel{
    var point = 0
    var sellerId = 0
    var serviceId = 0
    var comment = ""
}

struct AddNewRateBaseServiceParams{
    var point: Int?
    var sellerId: Int?
    var serviceId: Int?
    var comment: String?
}


