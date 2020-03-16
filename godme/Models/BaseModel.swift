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
//    var ResultCode : CodeApi?
//    var MessageInfo = ""
    var max = ""
    var MessageInfo = ""
    var ResultCode: CodeApi?
    var numberOfResult = ""
    var offset = ""
    var validation_errors :[String] = []
    
    required init?(json: JSON) {
        guard json.error == nil else {
            return nil
        }
        ResultCode = CodeApi(rawValue: json["messageCode"].intValue)
        MessageInfo = json["message"].stringValue
        numberOfResult = json["numberOfResult"].stringValue
        max = json["max"].stringValue
        offset = json["offset"].stringValue
//        ResultCode =  CodeApi(rawValue: json["ResultCode"].intValue)
//        MessageInfo = json["MessageInfo"].stringValue
    }
}
