//
//  ProvinceModel.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProvinceModel: BaseModel{
    
    var ProvinceArr: [ProvinceArrModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listProvince = json.array {
            ProvinceArr = [ProvinceArrModel]()
            for item in listProvince {
                ProvinceArr?.append(ProvinceArrModel(json: item)!)
            }
        }
    }
    
}

class ProvinceArrModel: BaseModel {
    var name: String?
    var slug: String?
    var type : String?
    var name_with_type: String?
    var code: String?
    var parent_code: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        name = json["name"].stringValue
        slug = json["slug"].stringValue
        type = json["type"].stringValue
        name_with_type = json["name_with_type"].stringValue
        code = json["code"].stringValue
        parent_code = json["parent_code"].stringValue
    }
}

////////// country

class CountryModel: BaseModel{
    
    var CountryArr: [CountryArrModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listCountry = json.array {
            CountryArr = [CountryArrModel]()
            for item in listCountry {
                CountryArr?.append(CountryArrModel(json: item)!)
            }
        }
    }
    
}

class CountryArrModel: BaseModel {
    
    var name: String?
    var phoneCode : String?
    var code: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        name = json["name"].stringValue
        code = json["code"].stringValue
        phoneCode = json["phoneCode"].stringValue
    }
}

//////////// district
class DistrictModel: BaseModel{
    
    var DistrictArr: [DistrictArrModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listDistrict = json.array {
            DistrictArr = [DistrictArrModel]()
            for item in listDistrict {
                DistrictArr?.append(DistrictArrModel(json: item)!)
            }
        }
    }
    
}

class DistrictArrModel: BaseModel {
    
    var name: String?
    var type: String?
    var slug: String?
    var name_with_type: String?
    var path: String?
    var path_with_type: String?
    var parent_code : String?
    var code: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        name = json["name"].stringValue
        type = json["type"].stringValue
        name_with_type = json["name_with_type"].stringValue
        path = json["path"].stringValue
        path_with_type = json["path_with_type"].stringValue
        parent_code = json["parent_code"].stringValue
        code = json["code"].stringValue
        slug = json["slug"].stringValue
    }
}

///// ward

class WardModel: BaseModel{
    
    var WardArr: [WardArrModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listWard = json.array {
            WardArr = [WardArrModel]()
            for item in listWard {
                WardArr?.append(WardArrModel(json: item)!)
            }
        }
    }
    
}

class WardArrModel: BaseModel {
    
    var name: String?
    var type: String?
    var slug: String?
    var name_with_type: String?
    var path: String?
    var path_with_type: String?
    var parent_code : String?
    var code: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        name = json["name"].stringValue
        type = json["type"].stringValue
        name_with_type = json["name_with_type"].stringValue
        path = json["path"].stringValue
        path_with_type = json["path_with_type"].stringValue
        parent_code = json["parent_code"].stringValue
        code = json["code"].stringValue
        slug = json["slug"].stringValue
    }
}

/////// education

class EducationModel: BaseModel{
    
    var EducationArr: [EducationArrModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listEducation = json.array {
            EducationArr = [EducationArrModel]()
            for item in listEducation {
                EducationArr?.append(EducationArrModel(json: item)!)
            }
        }
    }
    
}

class EducationArrModel: BaseModel {
    
    var code: String?
    var label: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        code = json["code"].stringValue
        label = json["label"].stringValue
    }
}

// social

class SocialModel: BaseModel {

    var fb: String?
    var youtube: String?
    var email: String?
    var phone: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        fb = json["fb"].stringValue
        youtube = json["youtube"].stringValue
        email = json["email"].stringValue
        phone = json["phone"].stringValue
    }
}

