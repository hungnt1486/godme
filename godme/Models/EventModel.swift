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
    var startTime: Int32?
    var endTime: Int32?
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
    var createdOn: Int32?
    var createdBy: String?
    var modifiedOn: Int32?
    var userInfo: userInfoModel?
    var isRelationshipWithSeller: Bool?
    
    required init?(json: JSON) {
        super.init(json: json)
        startTime = json["startTime"].int32Value
        endTime = json["endTime"].int32Value
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
        createdOn = json["createdOn"].int32Value
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].int32Value
        userInfo = userInfoModel.init(json: json["userInfo"])
        isRelationshipWithSeller = json["isRelationshipWithSeller"].boolValue
    }
}
