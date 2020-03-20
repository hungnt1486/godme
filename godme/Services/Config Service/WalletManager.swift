//
//  WalletManager.swift
//  godme
//
//  Created by fcsdev on 3/20/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class WalletManager{
    class func shareWalletManager() -> WalletManager {
        struct Static {static let _shareWalletManager = WalletManager()}
        return Static._shareWalletManager
    }
    
    func getAmountCharity(completion:@escaping(SingleResult<WalletCharityModel>) -> Void){
        Alamofire.request(URLs.getAmountCharity, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BaseViewController.headers).responseJSON { (response) in
            print("getAmountCharity = \(response)")
            completion(SingleResult<WalletCharityModel>.handleResponse(response))
        }
    }
}
