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
    // for live https://godme.vn:8443
//    static let linkServer = "https://godme.vn/"
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
        static let searchOrderBaseService = "api/mobile/order/basic/search"
        static let confirmOrderBaseService = "api/mobile/order/basic/update"
        static let createAuctionService = "api/mobile/service/auction/save"
        static let searchAuctionService = "api/mobile/service/auction/search"
        static let searchOrderAuctionService = "api/mobile/order/auction/search"
        static let getListAuctionService = "api/mobile/service/auction/getListService"
        static let searchRelationShips = "api/mobile/relationship/search"
        static let showRelationShip = "api/mobile/user/showRelationship"
        static let hideRelationShip = "api/mobile/user/hideRelationship"
        static let agreeConnect = "api/mobile/notification/agreeConnect"
        static let connectToUser = "api/mobile/notification/connectToUser"
        static let addGroupRelationShip = "api/mobile/groupRelationship/save"
        static let updateGroupRelationShip = "api/mobile/groupRelationship/update"
        static let deleteGroupRelationShip = "api/mobile/groupRelationship/delete"
        static let addUserToMultiGroupRelationShip = "api/mobile/groupRelationship/addUserToGroups"
        static let searchGroupRelationShip = "api/mobile/groupRelationship/search"
        static let sendEmailRelationShip = "api/mobile/groupRelationship/sendMailSupport"
        static let getListEventService = "api/mobile/service/event/getListService"
        static let createEventService = "api/mobile/service/event/save"
        static let searchEventService = "api/mobile/service/event/search"
        static let searchOrderEventService = "api/mobile/order/event/search"
        static let getListCollaborationService = "api/mobile/service/cooperation/getListService"
        static let createCollaborationService = "api/mobile/service/cooperation/save"
        static let getAmountCharity = "api/mobile/wallet/getAmountCharity"
        static let getListBlogs = "api/web/article/search"
        static let getListSearch = "api/mobile/user/search"
        static let getListJob = "api/mobile/career/search"
        static let confirmBookBaseService = "api/mobile/order/basic/save"
        static let createSupport = "api/public/support/save"
        static let createPushNotification = "api/mobile/notification/save"
        static let createContinueRelation = "api/mobile/transaction/extensionReferral"
        static let createRequestPayIn = "api/mobile/transaction/requestPayin"
        static let searchServiceOnMap = "api/mobile/user/findServiceOnMap"
        static let createOrderEventSave = "api/mobile/order/event/save"
        static let getMyWallet = "api/mobile/wallet/getMyWallet"
        static let getListTransaction = "api/mobile/transaction/search"
        static let getListHistory = "api/mobile/order/transaction/getHistory"
        
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
    
    static var getListSearch: String{
        return String(format: "%@%@", linkServer, Routes.getListSearch)
    }
    static var getListJob: String{
        return String(format: "%@%@", linkServer, Routes.getListJob)
    }
    static var createRequestPayIn: String{
        return String(format: "%@%@", linkServer, Routes.createRequestPayIn)
    }
    static var getMyWallet: String{
        return String(format: "%@%@", linkServer, Routes.getMyWallet)
    }
    static var getListTransaction: String{
        return String(format: "%@%@", linkServer, Routes.getListTransaction)
    }
    static var getListHistory: String{
        return String(format: "%@%@", linkServer, Routes.getListHistory)
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
    static var createContinueRelation: String{
        return String(format: "%@%@", linkServer, Routes.createContinueRelation)
    }
    static var deleteGroupRelationShip: String{
        return String(format: "%@%@", linkServer, Routes.deleteGroupRelationShip)
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
    static var confirmBookBaseService: String{
        return String(format: "%@%@", linkServer, Routes.confirmBookBaseService)
    }
    static var searchOrderBaseService: String{
        return String(format: "%@%@", linkServer, Routes.searchOrderBaseService)
    }
    static var confirmOrderBaseService:String{
        return String(format: "%@%@", linkServer, Routes.confirmOrderBaseService)
    }
    
    /// auction service
    static var getListAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.getListAuctionService)
    }
    static var createAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.createAuctionService)
    }
    static var searchAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.searchAuctionService)
    }
    static var searchOrderAuctionService: String{
        return String(format: "%@%@", linkServer, Routes.searchOrderAuctionService)
    }
    
    /// event service
    static var getListEventService: String{
        return String(format: "%@%@", linkServer, Routes.getListEventService)
    }
    static var createEventService: String{
        return String(format: "%@%@", linkServer, Routes.createEventService)
    }
    static var searchEventService: String{
        return String(format: "%@%@", linkServer, Routes.searchEventService)
    }
    static var searchOrderEventService: String{
        return String(format: "%@%@", linkServer, Routes.searchOrderEventService)
    }
    static var createOrderEventSave: String{
        return String(format: "%@%@", linkServer, Routes.createOrderEventSave)
    }
    
    ////  collaboration service
    static var getListCollaborationService: String{
        return String(format: "%@%@", linkServer, Routes.getListCollaborationService)
    }
    static var createCollaborationService: String{
        return String(format: "%@%@", linkServer, Routes.createCollaborationService)
    }
    
    // wallet
    static var getAmountCharity: String{
        return String(format: "%@%@", linkServer, Routes.getAmountCharity)
    }
    
    /// blog
    static var getListBlogs: String{
        return String(format: "%@%@", linkServer, Routes.getListBlogs)
    }
    
    // support (help)
    static var createSupport: String{
        return String(format: "%@%@", linkServer, Routes.createSupport)
    }
    static var createPushNotification: String{
        return String(format: "%@%@", linkServer, Routes.createPushNotification)
    }
    
    // map
    static var searchServiceOnMap: String{
        return String(format: "%@%@", linkServer, Routes.searchServiceOnMap)
    }
    
}
