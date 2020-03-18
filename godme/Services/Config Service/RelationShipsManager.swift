//
//  RelationShipsManager.swift
//  godme
//
//  Created by Lê Hùng on 3/18/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RelationShipsManager{
    class func shareRelationShipsManager() -> RelationShipsManager {
        struct Static {static let _shareRelationShipsManager = RelationShipsManager()}
        return Static._shareRelationShipsManager
    }
    
    func getListRelationShip(completion: @escaping(ListResult<BaseModel>) -> Void){
        
        Alamofire.request(URLs.getRelationShip, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListRelationShipExpand(completion: @escaping(ListResult<BaseModel>) -> Void){
        
        Alamofire.request(URLs.getRelationshipExpand, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListHiden(completion: @escaping(ListResult<BaseModel>) -> Void){
        
        Alamofire.request(URLs.getListHiden, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseModel>.handleResponse(response))
        }
    }
}
