//
//  Result.swift
//  MVVMRoot
//
//  Created by Apple on 8/23/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum SingleResult<C: BaseModel> {
    case success(C)
    case failure(message: String)
    
    static func handleResponse(_ response: DataResponse<Any>) -> SingleResult {
        guard let value = response.result.value else {
            return SingleResult.failure(message: "Lỗi hệ thống")
        }
        
        let json = JSON(value)
        let error = C(json: json)
        let result = C(json: json["Data"])!
        
        if error?.ResultCode == .Error {
            return SingleResult.failure(message: error?.MessageInfo ?? "")
        }
        
        return SingleResult.success(result)
    }
}

enum ListResult<C: BaseModel> {
    case success([C])
    case failure(message: String)
    
    static func handleResponse(_ response: DataResponse<Any>) -> ListResult {
        guard let value = response.result.value else {
            return ListResult.failure(message: "Lỗi hệ thống")
        }
        
        let json = JSON(value)
        let error = C(json: json)
        var result = [C]()
        if let items = json["Data"].array {
            for data in items {
                result.append(C(json: data)!)
            }
        }
        
        if error?.ResultCode == .Error {
            return ListResult.failure(message: error!.MessageInfo)
        }
        
        return ListResult.success(result)
        
    }
}

enum OneResult<C: BaseModel> {
    case success(Int)
    case failure(message: String)
    static func handleResponse(_ response: DataResponse<Any>) -> OneResult {
        guard let value = response.result.value else {
            return OneResult.failure(message: "Lỗi hệ thống")
        }
        
        let json = JSON(value)
        let error = C(json: json)
        let result = json["Data"].intValue
        
        if error?.ResultCode == .Error {
            return OneResult.failure(message: error?.MessageInfo ?? "")
        }
        
        return OneResult.success(result)
    }
}

enum OneBoolResult<C: BaseModel> {
    case success(Bool)
    case failure(message: String)
    static func handleResponse(_ response: DataResponse<Any>) -> OneBoolResult {
        guard let value = response.result.value else {
            return OneBoolResult.failure(message: "Lỗi hệ thống")
        }
        
        let json = JSON(value)
        let error = C(json: json)
        let result = json["Data"].boolValue
        
        if error?.ResultCode == .Error {
            return OneBoolResult.failure(message: error?.MessageInfo ?? "")
        }
        
        return OneBoolResult.success(result)
    }
}

enum OneResultString<C: BaseModel> {
    case success(String)
    case failure(message: String)
    static func handleResponse(_ response: DataResponse<Any>) -> OneResultString {
        guard let value = response.result.value else {
            return OneResultString.failure(message: "Lỗi hệ thống")
        }
        
        let json = JSON(value)
        let error = C(json: json)
        let result = json["Data"].stringValue
        
        if error?.ResultCode == .Error {
            return OneResultString.failure(message: error?.MessageInfo ?? "")
        }
        
        return OneResultString.success(result)
    }
}
