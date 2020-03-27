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
    
    func getListBaseService(completion: @escaping(ListResult<BaseServiceModel>) -> Void){
        
        Alamofire.request(URLs.getListBaseService, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<BaseServiceModel>.handleResponse(response))
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
    
    func searchBaseService(createdByUserId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<BaseServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["createdByUserId"] = createdByUserId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchBaseService = \(response)")
            completion(ListResult<BaseServiceModel>.handleResponse(response))
        }
    }
    
    func getDetailBaseService(id: Int, completion: @escaping(SingleResult<BaseServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.searchBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getDetailBaseService = \(response)")
            completion(SingleResult<BaseServiceModel>.handleResponse(response))
        }
    }
    
    func searchOrderBaseService(buyerId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<BaseServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["buyerId"] = buyerId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchOrderBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchOrderBaseService = \(response)")
            completion(ListResult<BaseServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func getListOrderBaseService(sellerId: Int, serviceId: Int, completion: @escaping(ListResult<BaseServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sellerId"] = sellerId
        paramsBody["serviceId"] = serviceId
        Alamofire.request(URLs.searchOrderBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListOrderBaseService = \(response)")
            completion(ListResult<BaseServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func confirmOrderBaseService(id: Int, status: String, completion:@escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        paramsBody["status"] = status
        Alamofire.request(URLs.confirmOrderBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("confirmOrderBaseService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListAuctionService(completion: @escaping(ListResult<AuctionServiceModel>) -> Void){
        Alamofire.request(URLs.getListAuctionService, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<AuctionServiceModel>.handleResponse(response))
        }
    }
    
    func createAuctionService(model: AddNewAuctionServiceParams, completion:@escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["title"] = model.title
        paramsBody["startTime"] = model.startTime
        paramsBody["endTime"] = model.endTime
        paramsBody["description"] = model.description
        paramsBody["address"] = model.address
        paramsBody["latitude"] = model.latitude
        paramsBody["longitude"] = model.longitude
        paramsBody["language"] = model.language
        paramsBody["amount"] = model.amount
        paramsBody["priceStep"] = model.priceStep
        paramsBody["images"] = model.images
        Alamofire.request(URLs.createAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createAuctionService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func searchAuctionService(createdByUserId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<AuctionServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["createdByUserId"] = createdByUserId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchAuctionService = \(response)")
            completion(ListResult<AuctionServiceModel>.handleResponse(response))
        }
    }
    
    func searchOrderAuctionService(buyerId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<AuctionServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["buyerId"] = buyerId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchOrderAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchOrderAuctionService = \(response)")
            completion(ListResult<AuctionServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func getListOrderAuctionService(sellerId: Int, serviceId: Int, completion: @escaping(ListResult<AuctionServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sellerId"] = sellerId
        paramsBody["serviceId"] = serviceId
        Alamofire.request(URLs.searchOrderAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListOrderAuctionService = \(response)")
            completion(ListResult<AuctionServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func getListEventService(type: String, completion: @escaping(ListResult<EventModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceType"] = type
        Alamofire.request(URLs.getListEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print(response)
            completion(ListResult<EventModel>.handleResponse(response))
        }
    }
    
    func searchEventService(createdByUserId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<EventModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["createdByUserId"] = createdByUserId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchEventService = \(response)")
            completion(ListResult<EventModel>.handleResponse(response))
        }
    }
    
    func searchOrderEventService(buyerId: Int, sorts: [[String: String]], page: Int, pageSize: Int, completion: @escaping(ListResult<EventServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["buyerId"] = buyerId
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchOrderEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchOrderEventService = \(response)")
            completion(ListResult<EventServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func getListOrderEventService(sellerId: Int, serviceId: Int, completion: @escaping(ListResult<EventServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sellerId"] = sellerId
        paramsBody["serviceId"] = serviceId
        Alamofire.request(URLs.searchOrderEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListOrderEventService = \(response)")
            completion(ListResult<EventServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func createEventService(model: AddNewAuctionServiceParams, completion:@escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["title"] = model.title
        paramsBody["startTime"] = model.startTime
        paramsBody["endTime"] = model.endTime
        paramsBody["description"] = model.description
        paramsBody["address"] = model.address
        paramsBody["latitude"] = model.latitude
        paramsBody["longitude"] = model.longitude
        paramsBody["language"] = model.language
        paramsBody["amount"] = model.amount
        paramsBody["images"] = model.images
        Alamofire.request(URLs.createEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createEventService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListCollaborationService(type: String, content: String, completion: @escaping(ListResult<CollaborationModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceType"] = type
        paramsBody["content"] = content
        Alamofire.request(URLs.getListCollaborationService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListCollaborationService = \(response)")
            completion(ListResult<CollaborationModel>.handleResponse(response))
        }
    }
    
    func createCollaborationService(model: AddNewCollaborationParams, completion:@escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["title"] = model.title
        paramsBody["description"] = model.description
        paramsBody["content"] = model.content
        Alamofire.request(URLs.createCollaborationService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createCollaborationService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListBlogsService(limit: Int = 10, sort: [[String: String]] = [["field" : "createdOn"], ["order" : "desc"]], completion:@escaping(ListResult<BlogModel>)->Void){
        var paramsBody = [String: Any]()
        paramsBody["limit"] = limit
        paramsBody["sort"] = sort
        Alamofire.request(URLs.getListBlogs, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListBlogsService = \(response)")
            completion(ListResult<BlogModel>.handleResponse(response))
        }
    }
    
    func confirmBookBaseService(model: AddNewConfirmBasicServiceParams, completion: @escaping(SingleResult<BaseModel>)-> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceId"] = model.serviceId
        paramsBody["sellerId"] = model.sellerId
        paramsBody["buyerId"] = model.buyerId
        paramsBody["amount"] = model.amount
        paramsBody["dateTime"] = model.dateTime
        Alamofire.request(URLs.confirmBookBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("confirmBookBaseService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
}
