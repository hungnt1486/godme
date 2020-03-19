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
    
    var dateTime1: String?
    var dateTime2: String?
    var dateTime3: String?
    var dateTime4: String?
    var dateTime5: String?
    var dateTime6: String?
    var dateTime7: String?
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
    var createdOn: Int32?
    var createdBy: String?
    var modifiedOn: Int32?
    var createdByUserId: Int?
    var isRelationshipWithSeller: Bool?
    var userInfo: userInfoModel?
    
    required init?(json: JSON) {
        super.init(json: json)
        dateTime1 = json["dateTime1"].stringValue
        dateTime2 = json["dateTime2"].stringValue
        dateTime3 = json["dateTime3"].stringValue
        dateTime4 = json["dateTime4"].stringValue
        dateTime5 = json["dateTime5"].stringValue
        dateTime6 = json["dateTime6"].stringValue
        dateTime7 = json["dateTime7"].stringValue
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
        createdOn = json["createdOn"].int32Value
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].int32Value
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
    
    required init?(json: JSON) {
        super.init(json: json)
        id = json["id"].intValue
        userCategory = json["userCategory"].stringValue
        fullName = json["fullName"].stringValue
        career = json["career"].stringValue
        totalStar = json["totalStar"].floatValue
        address = json["address"].stringValue
    }
}

struct AddNewBaseServiceParams {
    var title: String?
    var dateTime1: String?
    var dateTime2: String?
    var dateTime3: String?
    var dateTime4: String?
    var dateTime5: String?
    var dateTime6: String?
    var dateTime7: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var description: String?
    var language: Int?
    var amount: String?
    var images: String?
}



