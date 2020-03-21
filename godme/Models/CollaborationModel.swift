//
//  CollaborationModel.swift
//  godme
//
//  Created by fcsdev on 3/20/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class CollaborationModel: BaseModel {
    var status: String?
    var title: String?
    var description: String?
    var images: String?
    var id: Int?
    var createdOn: Int32?
    var createdBy: String?
    var modifiedOn: Int32?
    var userInfo: userInfoModel?
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var hope: String?
    var content: String?
    var createdByUserId: Int?
    
    required init?(json: JSON) {
        super.init(json: json)
        createdByUserId = json["createdByUserId"].intValue
        content = json["content"].stringValue
        hope = json["hope"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        email = json["email"].stringValue
        fullName = json["fullName"].stringValue
        status = json["status"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        images = json["images"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].int32Value
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].int32Value
        userInfo = userInfoModel.init(json: json["userInfo"])
    }
}

struct AddNewCollaborationParams{
    var title: String?
    var description: String?
    var content: String?
}

class BlogModel: BaseModel {
    var title: String?
    var image: String?
    var tags: String?
    var description: String?
    var content: String?
    var id: Int?
    var createdOn: Int32?
    var createdBy: String?
    var modifiedOn: Int32?
    var createdByUserId: Int?
    
    required init?(json: JSON) {
        super.init(json: json)
        title = json["title"].stringValue
        image = json["image"].stringValue
        tags = json["tags"].stringValue
        description = json["description"].stringValue
        content = json["content"].stringValue
        id = json["id"].intValue
        createdOn = json["createdOn"].int32Value
        createdBy = json["createdBy"].stringValue
        modifiedOn = json["modifiedOn"].int32Value
        createdByUserId = json["createdByUserId"].intValue
    }
}
