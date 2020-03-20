//
//  WalletModel.swift
//  godme
//
//  Created by fcsdev on 3/20/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletCharityModel: BaseModel {
    var totalAmountGodmeCharity: String?
    var totalAmountUserCharity: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        totalAmountGodmeCharity = json["totalAmountGodmeCharity"].stringValue
        totalAmountUserCharity = json["totalAmountUserCharity"].stringValue
    }
}
