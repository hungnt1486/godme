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
    
    
}
