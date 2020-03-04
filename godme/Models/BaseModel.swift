//
//  BaseModel.swift
//  MVVMRoot
//
//  Created by Apple on 8/23/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseModel {
    var ResultCode : CodeApi?
    var MessageInfo = ""
    
    required init?(json: JSON) {
        guard json.error == nil else {
            return nil
        }
        ResultCode =  CodeApi(rawValue: json["ResultCode"].intValue)   
        MessageInfo = json["MessageInfo"].stringValue
    }
}
