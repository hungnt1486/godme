//
//  EventModel.swift
//  godme
//
//  Created by fcsdev on 3/20/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class EventModel: BaseModel{
    var startTime: Double?
    var endTime: Double?
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
    var maxOrder: Int?
    var amountOriginal: String?
    var currentWinner: String?
    var id: Int?
    var createdOn: Double?
    var createdBy: String?
    var modifiedOn: Double?
    var userInfo: userInfoModel?
    var isRelationshipWithSeller: Bool?
    
    required init?(json: JSON) {
        super.init(json: json)
        startTime = json["startTime"].doubleValue
        endTime = json["endTime"].doubleValue
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
        maxOrder = json["maxOrder"].intValue
        amountOriginal = json["amountOriginal"].stringValue
        currentWinner = json["currentWinner"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].doubleValue
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].doubleValue
        userInfo = userInfoModel.init(json: json["userInfo"])
        isRelationshipWithSeller = json["isRelationshipWithSeller"].boolValue
    }
}

class EventServiceInfoBookedModel: BaseModel {
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
