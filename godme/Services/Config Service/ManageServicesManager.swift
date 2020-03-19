//
//  ManageServicesManager.swift
//  godme
//
//  Created by Lê Hùng on 3/18/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ManageServicesManager{
    class func shareManageServicesManager() -> ManageServicesManager {
        struct Static {static let _shareManageServicesManager = ManageServicesManager()}
        return Static._shareManageServicesManager
    }
    
    func getListBaseService(completion: @escaping(ListResult<BaseService>) -> Void){
        
        Alamofire.request(URLs.getListBaseService, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseService>.handleResponse(response))
        }
    }
    
    func createBaseService(model: AddNewBaseServiceParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["title"] = model.title
        paramsBody["dateTime1"] = model.dateTime1
        paramsBody["dateTime2"] = model.dateTime2
        paramsBody["dateTime3"] = model.dateTime3
        paramsBody["dateTime4"] = model.dateTime4
        paramsBody["dateTime5"] = model.dateTime5
        paramsBody["dateTime6"] = model.dateTime6
        paramsBody["dateTime7"] = model.dateTime7
        paramsBody["address"] = model.address
        paramsBody["latitude"] = model.latitude
        paramsBody["longitude"] = model.longitude
        paramsBody["description"] = model.description
        paramsBody["language"] = model.language
        paramsBody["amount"] = model.amount
        paramsBody["images"] = model.images
        
        Alamofire.request(URLs.createBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createBaseService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
}
