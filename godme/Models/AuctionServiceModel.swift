//
//  AuctionServiceModel.swift
//  godme
//
//  Created by Lê Hùng on 3/19/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuctionServiceModel: BaseModel {
    var startTime: Double?
    var endTime: Double?
    var priceStep: String?
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
    var amountOriginal: String?
    var currentWinner: String?
    var id: Int?
    var createdOn: Int32?
    var createdBy: String?
    var modifiedOn: Int32?
    var userInfo: userInfoModel?
    var isRelationshipWithSeller: Bool?
    
    required init?(json: JSON) {
        super.init(json: json)
        startTime = json["startTime"].doubleValue
        endTime = json["endTime"].doubleValue
        priceStep = json["priceStep"].stringValue
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
        amountOriginal = json["amountOriginal"].stringValue
        currentWinner = json["currentWinner"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].int32Value
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].int32Value
        userInfo = userInfoModel.init(json: json["userInfo"])
        isRelationshipWithSeller = json["isRelationshipWithSeller"].boolValue
    }
}

class AuctionServiceInfoBookedModel: BaseModel {
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

struct AddNewAuctionServiceParams {
    
    var title: String?
    var startTime: Double?
    var endTime: Double?
    var description: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var language: String?
    var amount: String?
    var priceStep: String?
    var images: String?
}
