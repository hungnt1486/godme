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
        static let searchRelationShips = "api/mobile/relationship/search"
        static let showRelationShip = "api/mobile/user/showRelationship"
        static let hideRelationShip = "api/mobile/user/hideRelationship"
        static let agreeConnect = "api/mobile/notification/agreeConnect"
        static let connectToUser = "api/mobile/notification/connectToUser"
        static let addGroupRelationShip = "api/mobile/groupRelationship/save"
        static let updateGroupRelationShip = "api/mobile/groupRelationship/update"
        static let addUserToMultiGroupRelationShip = "api/mobile/groupRelationship/addUserToGroups"
        static let searchGroupRelationShip = "api/mobile/groupRelationship/search"
        static let sendEmailRelationShip = "api/mobile/groupRelationship/sendMailSupport"
        static let getListEventService = "api/mobile/service/event/getListService"
        static let createEventService = "api/mobile/service/event/save"
        static let getListCollaborationService = "api/mobile/service/cooperation/getListService"
        static let createCollaborationService = "api/mobile/service/cooperation/save"
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
    static var searchRelationShips: String{
        return String(format: "%@%@", linkServer, Routes.searchRelationShips)
    }
    static var showRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.showRelationShip)
    }
    static var hideRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.hideRelationShip)
    }
    static var agreeConnect: String{
        return String(format: "%@%@", linkServer, Routes.agreeConnect)
    }
    static var connectToUser: String{
        return String(format: "%@%@", linkServer, Routes.connectToUser)
    }
    static var addGroupRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.addGroupRelationShip)
    }
    static var updateGroupRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.updateGroupRelationShip)
    }
    static var addUserToMultiGroupRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.addUserToMultiGroupRelationShip)
    }
    static var searchGroupRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.searchGroupRelationShip)
    }
    static var sendEmailRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.sendEmailRelationShip)
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
    
    /// event service
    static var getListEventService: String{
        return String(format: "%@%@", linkServer, Routes.getListEventService)
    }
    static var createEventService: String{
        return String(format: "%@%@", linkServer, Routes.createEventService)
    }
    
    //// event collaboration
    static var getListCollaborationService: String{
        return String(format: "%@%@", linkServer, Routes.getListCollaborationService)
    }
    static var createCollaborationService: String{
        return String(format: "%@%@", linkServer, Routes.createCollaborationService)
    }
    
}
