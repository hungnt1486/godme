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
    
    func getListBaseService(page: Int, pageSize: Int, sorts: [[String: String]], completion: @escaping(ListResult<BaseServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListBaseService = \(response)")
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
    
    func getListBaseServiceByCurrentService(currentServiceId: Int, page: Int, pageSize: Int, completion: @escaping(ListResult<BaseServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["currentServiceId"] = currentServiceId
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListBaseServiceByCurrentService = \(response)")
            completion(ListResult<BaseServiceModel>.handleResponse(response))
        }
    }
    
    func getDetailBaseService(id: Int, completion: @escaping(ListResult<BaseServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.searchBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getDetailBaseService = \(response)")
            completion(ListResult<BaseServiceModel>.handleResponse(response))
        }
    }
    
    func rateBaseService(model: AddNewRateBaseServiceParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["point"] = model.point
        paramsBody["sellerId"] = model.sellerId
        paramsBody["serviceId"] = model.serviceId
        Alamofire.request(URLs.rateBaseService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("rateBaseService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
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
    
    func getListOrderBaseServiceDetail(serviceId: Int, completion: @escaping(ListResult<BaseServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
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
    
    func getListAuctionService(page: Int, pageSize: Int, sorts: [[String: String]], ge: [[String: String]], completion: @escaping(ListResult<AuctionServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["ge"] = ge
        Alamofire.request(URLs.searchAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
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
    
    func getListAuctionServiceByCurrentService(currentServiceId: Int, page: Int, pageSize: Int, completion: @escaping(ListResult<AuctionServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["currentServiceId"] = currentServiceId
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListAuctionServiceByCurrentService = \(response)")
            completion(ListResult<AuctionServiceModel>.handleResponse(response))
        }
    }
    
    func getDetailAuctionService(id: Int, completion: @escaping(ListResult<AuctionServiceModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.searchAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getDetailAuctionService = \(response)")
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
    
    func getListOrderAuctionServiceDetail(serviceId: Int, completion: @escaping(ListResult<AuctionServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceId"] = serviceId
        Alamofire.request(URLs.searchOrderAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListOrderAuctionServiceDetail = \(response)")
            completion(ListResult<AuctionServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func rateAuctionService(model: AddNewRateBaseServiceParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["point"] = model.point
        paramsBody["sellerId"] = model.sellerId
        paramsBody["serviceId"] = model.serviceId
        Alamofire.request(URLs.rateAuctionService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("rateAuctionService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func createOrderAuction(sellerId: Int, serviceId: Int, buyerId: Int, amount: Double, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sellerId"] = sellerId
        paramsBody["serviceId"] = serviceId
        paramsBody["buyerId"] = buyerId
        paramsBody["amount"] = amount
        Alamofire.request(URLs.createOrderAuction, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createOrderAuction = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListEventService(page: Int, pageSize: Int, sorts: [[String: String]], ge: [[String: String]], completion: @escaping(ListResult<EventModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["ge"] = ge
        Alamofire.request(URLs.searchEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
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
    
    func getListEventServiceByCurrentService(currentServiceId: Int, page: Int, pageSize: Int, completion: @escaping(ListResult<EventModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["currentServiceId"] = currentServiceId
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        Alamofire.request(URLs.searchEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListEventServiceByCurrentService = \(response)")
            completion(ListResult<EventModel>.handleResponse(response))
        }
    }
    
    func getDetailEventService(id: Int, completion: @escaping(ListResult<EventModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.searchEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getDetailEventService = \(response)")
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
    
    func getListOrderEventServiceDetail(serviceId: Int, completion: @escaping(ListResult<EventServiceInfoBookedModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceId"] = serviceId
        Alamofire.request(URLs.searchOrderEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListOrderEventServiceDetail = \(response)")
            completion(ListResult<EventServiceInfoBookedModel>.handleResponse(response))
        }
    }
    
    func rateEventService(model: AddNewRateBaseServiceParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["point"] = model.point
        paramsBody["sellerId"] = model.sellerId
        paramsBody["serviceId"] = model.serviceId
        Alamofire.request(URLs.rateEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("rateEventService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
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
        paramsBody["maxOrder"] = model.maxOrder
        Alamofire.request(URLs.createEventService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createEventService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListCollaborationService(page: Int, pageSize: Int, sorts: [[String: String]], completion: @escaping(ListResult<CollaborationModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["sorts"] = sorts
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
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
        paramsBody["fullName"] = model.fullName
        paramsBody["email"] = model.email
        paramsBody["phoneNumber"] = model.phoneNumber
        paramsBody["images"] = model.images
        Alamofire.request(URLs.createCollaborationService, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createCollaborationService = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListCharityService(page: Int = 1, pageSize: Int = 1000, or: [[String: String]] = [["field" : "tags", "value":"QUY-TU-THIEN"], ["field":"tags","value":"CHARITY"]], completion:@escaping(ListResult<BlogModel>)->Void){
        var paramsBody = [String: Any]()
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["or"] = or
        Alamofire.request(URLs.getListBlogs, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListCharityService = \(response)")
            completion(ListResult<BlogModel>.handleResponse(response))
        }
    }
    
    func getListBlogsService(page: Int = 1, pageSize: Int = 1000, or: [[String: String]] = [["field" : "tags", "value":"BLOG"], ["field":"tags","value":"BAI-VIET"]], completion:@escaping(ListResult<BlogModel>)->Void){
        var paramsBody = [String: Any]()
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["or"] = or
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
    
    func createOrderEventSave(model: AddNewConfirmBasicServiceParams, completion: @escaping(SingleResult<BaseModel>)-> Void){
        var paramsBody = [String: Any]()
        paramsBody["serviceId"] = model.serviceId
        paramsBody["sellerId"] = model.sellerId
        paramsBody["buyerId"] = model.buyerId
        paramsBody["amount"] = model.amount
        Alamofire.request(URLs.createOrderEventSave, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createOrderEventSave = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func searchServiceOnMap(model: AddNewFindMapParams, completion: @escaping(ListResult<MapModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["centerLat"] = model.centerLat
        paramsBody["centerLong"] = model.centerLong
        paramsBody["keySearch"] = model.keySearch
        paramsBody["radius"] = model.radius
        paramsBody["services"] = model.services
        Alamofire.request(URLs.searchServiceOnMap, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("searchServiceOnMap = \(response)")
            completion(ListResult<MapModel>.handleResponse(response))
        }
    }
    
}
