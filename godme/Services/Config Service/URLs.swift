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
    }
    
    static var login: String{
        return String(format: "%@%@", linkServer, Routes.login)
    }
//    //method post
//    static var register: String{
//        return String(format: "%@%@", linkServer, Routes.register)
//    }
    
}
