//
//  URLs.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

struct URLs {
    // for test
    static let linkServer = "http://45.117.169.99:8888/godme-service/"
    // for live
//    static let linkServer = "http://cityf.vn/api-test/"
    private struct Routes{
        static let login = "api/v1/auth/login"
        static let changePassword = "api/v1/auth/changePassword"
        static let forgotPassword = "/api/v1/auth/forgotPassword"
        static let logout = "api/v1/auth/logout"
        static let getRelationship = "api/mobile/user/getRelationship"
        static let getRelationshipExpand = "api/mobile/user/getRelationshipExtend"
        static let getListHiden = "api/mobile/user/getListHiden"
        static let getListBaseService = "api/mobile/service/basic/getListService"
        static let createBaseService = "api/mobile/service/basic/save"
        static let searchBaseService = "api/mobile/service/basic/search"
        static let createAuctionService = "api/mobile/service/auction/save"
        static let getListAuctionService = "api/mobile/service/auction/getListService"
    }
    
    //// user
    static var login: String{
        return String(format: "%@%@", linkServer, Routes.login)
    }
    static var changePassword: String{
        return String(format: "%@%@", linkServer, Routes.changePassword)
    }
    static var forgotPassword: String{
        return String(format: "%@%@", linkServer, Routes.forgotPassword)
    }
    static var logout: String{
        return String(format: "%@%@", linkServer, Routes.logout)
    }
    
    /// relationship
    static var getRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.getRelationship)
    }
    static var getRelationshipExpand: String{
        return String(format: "%@%@", linkServer, Routes.getRelationshipExpand)
    }
    static var getListHiden: String{
        return String(format: "%@%@", linkServer, Routes.getListHiden)
    }
    
    /// base service
    static var getListBaseService: String{
        return String(format: "%@%@", linkServer, Routes.getListBaseService)
    }
    static var createBaseService: String{
        return String(format: "%@%@", linkServer, Routes.createBaseService)
    }
    
    static var searchBaseService: String{
        return String(format: "%@%@", linkServer, Routes.searchBaseService)
    }
    
    /// auction service
    static var getListAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.getListAuctionService)
    }
    static var createAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.createAuctionService)
    }
}
