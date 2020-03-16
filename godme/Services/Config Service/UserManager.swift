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
    
    func loginUser(Phone: String, Password: String, completion: @escaping (SingleResult<UserLoginReturnModel>) -> Void) {
        var paramsHeader = [String: Any]()
        var paramsBody = [String: Any]()
        paramsBody["Password"] = Password
        paramsBody["Phone"] = Phone
        paramsBody["OS"] = "ios"
        paramsBody["Version"] = Settings.ShareInstance.getVersionApp()
//        paramsBody["Udid"] = Settings.ShareInstance.getUDIDString()
//        paramsBody["DeviceToken"] = Settings.ShareInstance.deviceToken
//        paramsHeader["ActionName"] = ActionUser.UsersLogin
//        paramsHeader["ServiceCode"] = CodeService.User
        paramsHeader["Parameter"] = paramsBody
        Alamofire.request(Url.Domain, method: .post, parameters: paramsHeader, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            completion(SingleResult<UserLoginReturnModel>.handleResponse(response))
        }
    }
}
