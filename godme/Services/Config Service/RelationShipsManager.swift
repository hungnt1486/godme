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
    
//    func getListRelationShip(completion: @escaping(ListResult<RelationShipsModel>) -> Void){
//
//        Alamofire.request(URLs.getRelationShip, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
//            print(response)
//            completion(ListResult<RelationShipsModel>.handleResponse(response))
//        }
//    }
    
    func getListRelationShipFilter(careerId: Int, fullName: String, page: Int, pageSize: Int, completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["careerId"] = careerId
        paramsBody["fullName"] = fullName
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.getRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func getListRelationShipExpandFilter(careerId: Int, fullName: String, page: Int, pageSize: Int, completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["careerId"] = careerId
        paramsBody["fullName"] = fullName
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.getRelationshipExpand, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
    func getListHidenFilter(careerId: Int, fullName: String, page: Int, pageSize: Int, completion: @escaping(ListResult<RelationShipsModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["careerId"] = careerId
        paramsBody["fullName"] = fullName
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.getListHiden, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<RelationShipsModel>.handleResponse(response))
        }
    }
    
//    func searchRelationShip(keyword: String, type: String, completion:@escaping(ListResult<RelationShipsModel>) -> Void){
//        let urlRequest = URLs.searchRelationShips + "/" + keyword + "/" + type
//        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
//            print(response)
//            completion(ListResult<RelationShipsModel>.handleResponse(response))
//        }
//    }
    
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
            print("connectToUserRelationShip = \(response)")
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
    
    func searchGroupRelationShip(id: Int, completion: @escaping(ListResult<GroupRelationShipModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.searchGroupRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<GroupRelationShipModel>.handleResponse(response))
        }
    }
    
    func getSearchGroupRelationShip(completion: @escaping(ListResult<GroupRelationShipModel>) -> Void){
        
        Alamofire.request(URLs.searchGroupRelationShip, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getSearchGroupRelationShip = \(response)")
            completion(ListResult<GroupRelationShipModel>.handleResponse(response))
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
    
    func createPushNotification(model: AddNewPushNotificationServiceParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["description"] = model.description
        paramsBody["images"] = model.images
        paramsBody["title"] = model.title
        paramsBody["target"] = model.target
        paramsBody["relationship"] = model.relationship
        Alamofire.request(URLs.createPushNotification, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
}
