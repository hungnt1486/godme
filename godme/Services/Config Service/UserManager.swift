//
//  AccountManager.swift
//  godme
//
//  Created by fcsdev on 3/16/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserManager{
    class func shareUserManager() -> UserManager {
        struct Static {static let _shareUserManager = UserManager()}
        return Static._shareUserManager
    }
    
    func loginUser(username: String, password: String, completion: @escaping (SingleResult<UserLoginReturnModel>) -> Void) {
//        var paramsHeader = [String: Any]()
        var paramsBody = [String: Any]()
        var paramsBodySub = [String: Any]()
        paramsBody["username"] = username
        paramsBody["password"] = password
        paramsBodySub["os"] = "ios"
        paramsBodySub["osVersion"] = Settings.ShareInstance.getVersionApp()
        paramsBodySub["uuid"] = Settings.ShareInstance.getUDIDString()
        paramsBodySub["fcmToken"] = Settings.ShareInstance.deviceToken
        paramsBodySub["name"] = "iPhone"
        paramsBody["device"] = paramsBodySub
        Alamofire.request(URLs.login, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("loginUser = \(response)")
            completion(SingleResult<UserLoginReturnModel>.handleResponse(response))
        }
    }
    
    func changePassword(model: changePasswordParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["username"] = model.username
        paramsBody["password"] = model.password
        paramsBody["newPassword"] = model.newPassword
        Alamofire.request(URLs.changePassword, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("changePassword = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func forgotPassword(model: forgotPasswordParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["username"] = model.username
        paramsBody["codeOTP"] = model.codeOTP
        paramsBody["newPassword"] = model.newPassword
        Alamofire.request(URLs.forgotPassword, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("forgotPassword = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func sendOTPForgotPassword(email: String, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["email"] = email
        Alamofire.request(URLs.sendOTPForgotPassword, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("sendOTPForgotPassword = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func logout(completion: @escaping(SingleResult<BaseModel>) -> Void){
        Alamofire.request(URLs.logout, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("logout = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListSearch(model: userSearchParams, completion:@escaping(ListResult<UserRegisterReturnModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["keyword"] = model.keyword
        paramsBody["fullName"] = model.fullName
        paramsBody["gender"] = model.gender
        paramsBody["nationCode"] = model.nationCode
        paramsBody["education"] = model.education
        paramsBody["career"] = model.career
        paramsBody["provinceCode"] = model.provinceCode
        paramsBody["districtCode"] = model.districtCode
        paramsBody["wardCode"] = model.wardCode
        paramsBody["page"] = model.page
        paramsBody["pageSize"] = model.pageSize
        
        Alamofire.request(URLs.getListSearch, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListSearch = \(response)")
            completion(ListResult<UserRegisterReturnModel>.handleResponse(response))
        }
    }
    
    func getSearchDetailById(id: Int, completion:@escaping(ListResult<UserRegisterReturnModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        
        Alamofire.request(URLs.getListSearch, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getSearchDetailById = \(response)")
            completion(ListResult<UserRegisterReturnModel>.handleResponse(response))
        }
    }
    
    func getListMyRelationShip(id: Int, completion: @escaping(ListResult<UserRegisterReturnModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["userId"] = id
        Alamofire.request(URLs.getRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListMyRelationShip = \(response)")
            completion(ListResult<UserRegisterReturnModel>.handleResponse(response))
        }
    }
    
    func getMyRelationShip(id: Int, completion: @escaping(ListResult<UserRegisterReturnModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = id
        Alamofire.request(URLs.getRelationShip, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getMyRelationShip = \(response)")
            completion(ListResult<UserRegisterReturnModel>.handleResponse(response))
        }
    }
    
    func getListJobs(completion: @escaping(ListResult<JobModel>) -> Void){
        Alamofire.request(URLs.getListJob, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListJobs = \(response)")
            completion(ListResult<JobModel>.handleResponse(response))
        }
    }
    
    func createSupport(model: AddNewHelpServiceParams, completion: @escaping(SingleResult<BaseModel>)-> Void){
        var paramsBody = [String: Any]()
        paramsBody["content"] = model.description
        paramsBody["images"] = model.images
        paramsBody["title"] = model.title
        
        Alamofire.request(URLs.createSupport, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createSupport = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func createRequestPayIn(completion: @escaping(SingleResult<BaseModel>)->Void){
        Alamofire.request(URLs.createRequestPayIn, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("createRequestPayIn = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getMyWallet(completion: @escaping(ListResult<MyWalletModel>) -> Void){
        Alamofire.request(URLs.getMyWallet, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getMyWallet = \(response)")
            completion(ListResult<MyWalletModel>.handleResponse(response))
        }
    }
    
    func getListTransaction(page: Int, pageSize: Int, sorts:[[String: String]], completion: @escaping(ListResult<TransactionModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["sorts"] = sorts
        
        Alamofire.request(URLs.getListTransaction, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListTransaction = \(response)")
            completion(ListResult<TransactionModel>.handleResponse(response))
        }
    }
    
    func getListTransactionFilter(page: Int, pageSize: Int, sorts:[[String: String]], ge:[[String: String]], le:[[String: String]], completion: @escaping(ListResult<TransactionModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["page"] = page
        paramsBody["pageSize"] = pageSize
        paramsBody["sorts"] = sorts
        paramsBody["ge"] = ge
        paramsBody["le"] = le
        Alamofire.request(URLs.getListTransaction, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListTransactionFilter = \(response)")
            completion(ListResult<TransactionModel>.handleResponse(response))
        }
    }
    
    func getListHistory(month: Int, year: Int, completion: @escaping(SingleResult<HistoryModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["month"] = month
        paramsBody["year"] = year
        Alamofire.request(URLs.getListHistory, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListHistory = \(response)")
            completion(SingleResult<HistoryModel>.handleResponse(response))
        }
    }
    
    func getUserInfo(completion: @escaping(ListResult<UserRegisterReturnModel>) -> Void){
        Alamofire.request(URLs.getUserInfo, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getUserInfo = \(response)")
            completion(ListResult<UserRegisterReturnModel>.handleResponse(response))
        }
    }
    
    func updateUserInfo(model: AddNewUserProfileParams, completion: @escaping(SingleResult<BaseModel>) -> Void){
        var paramsBody = [String: Any]()
        paramsBody["id"] = model.id
        paramsBody["idNumber"] = model.idNumber
        paramsBody["avatar"] = model.avatar
        paramsBody["fullName"] = model.fullName
        paramsBody["gender"] = model.gender
        paramsBody["position"] = model.position
        paramsBody["education"] = model.education
        paramsBody["experience"] = model.experience
        paramsBody["dob"] = model.dob
        paramsBody["career"] = model.career
        paramsBody["email"] = model.email
        paramsBody["userInfo"] = model.userInfo
        paramsBody["nationCode"] = model.nationCode
        paramsBody["nationName"] = model.nationName
        paramsBody["provinceCode"] = model.provinceCode
        paramsBody["provinceName"] = model.provinceName
        paramsBody["districtCode"] = model.districtCode
        paramsBody["districtName"] = model.districtName
        paramsBody["wardCode"] = model.wardCode
        paramsBody["wardName"] = model.wardName
        paramsBody["address"] = model.address
        paramsBody["userCode"] = model.userCode
        paramsBody["amountConnect"] = model.amountConnect
        Alamofire.request(URLs.updateUserInfo, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("updateUserInfo = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func registerUser(model: AddNewRegisterParams, completion: @escaping(SingleResult<BaseModel>)-> Void){
        var paramsBody = [String: Any]()
        paramsBody["username"] = model.username
        paramsBody["password"] = model.password
        paramsBody["fullName"] = model.fullName
        paramsBody["email"] = model.email
        paramsBody["gender"] = model.gender
        paramsBody["nationCode"] = model.nationCode
        paramsBody["nationName"] = model.nationName
        paramsBody["provinceCode"] = model.provinceCode
        paramsBody["provinceName"] = model.provinceName
        paramsBody["districtCode"] = model.districtCode
        paramsBody["districtName"] = model.districtName
        paramsBody["wardCode"] = model.wardCode
        paramsBody["wardName"] = model.wardName
        paramsBody["dob"] = model.dob
        paramsBody["career"] = model.career
        paramsBody["address"] = model.address
        paramsBody["education"] = model.education
        paramsBody["codeOTP"] = model.codeOTP
        paramsBody["referralCode"] = model.referralCode
        Alamofire.request(URLs.register, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("registerUser = \(response)")
            completion(SingleResult<BaseModel>.handleResponse(response))
        }
    }
    
    func getListNotification(completion: @escaping(ListResult<NotificationModel>)-> Void){
        Alamofire.request(URLs.notificationSearch, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getListNotification = \(response)")
            completion(ListResult<NotificationModel>.handleResponse(response))
        }
    }
}
