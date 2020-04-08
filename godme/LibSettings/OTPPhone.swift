//
//  OTPPhone.swift
//  hune
//
//  Created by Apple on 12/23/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import Foundation
import FirebaseUI
import UIKit

class OTPPhone: NSObject {
    
    let authUI = FUIAuth.defaultAuthUI()
    var target: UIViewController?
    
    
    init(target: UIViewController) {
        self.target = target
        authUI?.delegate = target as? FUIAuthDelegate
        let providers: [FUIAuthProvider] = [
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
        ]
        self.authUI?.providers = providers
    }
    
    func signInPhone(phone: String) {
        let phoneProvider = FUIAuth.defaultAuthUI()?.providers.first as! FUIPhoneAuth
        if phone == "" {
             phoneProvider.signIn(withPresenting: target!, phoneNumber: nil)
        } else {
             phoneProvider.signIn(withPresenting: target!, phoneNumber: phone)
        }
    }
}
