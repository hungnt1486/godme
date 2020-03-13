//
//  ProvinceModel.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProvinceModel: BaseModel{
    
    var name: String?
    var slug: String?
    var type : String?
    var name_with_type: String?
    var code: Int?
    var parent_code: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        name = json["name"].stringValue
        slug = json["slug"].stringValue
        type = json["type"].stringValue
        name_with_type = json["name_with_type"].stringValue
        code = json["code"].intValue
        parent_code = json["parent_code"].stringValue
    }
}
