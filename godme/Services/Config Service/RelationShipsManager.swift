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
    
    func getListRelationShip(completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        
        Alamofire.request(URLs.getRelationShip, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func getListRelationShipExpand(completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        
        Alamofire.request(URLs.getRelationshipExpand, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func getListHiden(completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        
        Alamofire.request(URLs.getListHiden, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func searchRelationShip(keyword: String, type: String, completion:@escaping(ListResult<RelationShipsModel>) -> Void){
        let urlRequest = URLs.searchRelationShips + "/" + keyword + "/" + type
        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func showRelationShip(childrenId: Int, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["childrenId"] = childrenId
        Alamofire.request(URLs.showRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func hideRelationShip(childrenId: Int, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["childrenId"] = childrenId
        Alamofire.request(URLs.hideRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func agreeConnectRelationShip(id: Int, toUserId: Int, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        paramsBody["toUserId"] = toUserId
        Alamofire.request(URLs.agreeConnect, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func connectToUserRelationShip(toUserId: Int, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["toUserId"] = toUserId
        Alamofire.request(URLs.connectToUser, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func addGroupRelationShip(name: String, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["name"] = name
        Alamofire.request(URLs.addGroupRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func updateGroupRelationShip(id: Int, name: String, userIds: String, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["name"] = name
        paramsBody["id"] = id
        paramsBody["userIds"] = userIds
        Alamofire.request(URLs.updateGroupRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func addUserToMultiGroupRelationShip(listGroupId: [Int], listUserId: [Int], completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["listGroupId"] = listGroupId
        paramsBody["listUserId"] = listUserId
        Alamofire.request(URLs.addUserToMultiGroupRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func searchGroupRelationShip(id: Int, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.addGroupRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func sendEmailRelationShip(email: String, subject: String, phoneNumber: String, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["email"] = email
        paramsBody["subject"] = subject
        paramsBody["phoneNumber"] = phoneNumber
        Alamofire.request(URLs.sendEmailRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
}
