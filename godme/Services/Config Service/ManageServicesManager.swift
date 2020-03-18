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
    
    func getListBaseService(completion: @escaping(ListResult<BaseModel>) -> Void){
        
        Alamofire.request(URLs.getListBaseService, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseModel>.handleResponse(response))
        }
    }
}
