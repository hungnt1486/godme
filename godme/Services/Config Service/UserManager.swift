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
        paramsBodySub["fcmToken"] = "gwgwihgwiug"//Settings.ShareInstance.device
        paramsBodySub["name"] = "iPhone"
        paramsBody["device"] = paramsBodySub
        Alamofire.request(URLs.login, method: .post, parameters: paramsBody, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            completion(SingleResult<UserLoginReturnModel>.handleResponse(response))
        }
    }
}
