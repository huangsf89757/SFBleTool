//
//  DbDataProvider.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/30.
//

import Foundation
// Basic
import SFExtension
import SFBase
// Business
import SFBusiness
import SFUser
// Third
import WCDBSwift

// MARK: - DbDataProvider
class DbDataProvider: SFDataProvider {
    // MARK: var
    var timeout: TimeInterval = 30
}

// MARK: - SFUserApi
extension DbDataProvider: SFUserApi {
    func sendSmsCode(type: SFUser.SmsCodeType) async -> Bool {
        return true
    }
    
    func signIn(phone: String, code: String) async -> Bool {
        return true
    }
    
    func signIn(email: String, code: String) async -> Bool {
        return true
    }
    
    func signIn(account: String, pwd: String) async -> Bool {
        return true
    }
    
    func signIn(phone: String, pwd: String) async -> Bool {
        return true
    }
    
    func signIn(email: String, pwd: String) async -> Bool {
        return true
    }
    
    func signOut() async -> Bool {
        return true
    }
    
    func initialPwd(_ pwd: String) async -> Bool {
        return true
    }
    
    func resetPwd(_ pwd: String, phone: String, code: String) async -> Bool {
        return true
    }
    
    func resetPwd(_ pwd: String, email: String, code: String) async -> Bool {
        return true
    }
    
    func getInfo() async -> Bool {
        return true
    }
    
    func updateInfo(_ info: [String : Any]) async -> Bool {
        return true
    }
    
    func deleteAccount(pwd: String) async -> Bool {
        return true
    }
}
