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
    
    // MARK: value
    var smsCode: String?
    
}

// MARK: - SFUserApi
extension DbDataProvider: SFUserApi {
    func sendSmsCode(type: SFUser.SmsCodeType) async -> SFDataResponse {
        let logTag = "发送验证码"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        let smsCode = String((0..<6).compactMap { _ in
            "0123456789".randomElement()
        })
        SFDsLogger.debug(tag: logTag, step: .inProcess, msgs: "生成随机验证码", smsCode)
        self.smsCode = smsCode
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.smsCode = nil
            SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "验证码(\(smsCode))过期")
        }
        SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: smsCode)
        return (code: .ok, isSuccess: true, data: smsCode, message: "验证码发送成功")
    }
    
    func signIn(phone: String, code: String) async -> SFDataResponse {
        let logTag = "登录（手机号+验证码）"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let smsCode = smsCode else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码已过期，请重新发送")
        }
        guard smsCode == code else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "smsCode != code")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, code: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+验证码）"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let smsCode = smsCode else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码已过期，请重新发送")
        }
        guard smsCode == code else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "smsCode != code")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        do {
            let condition = BTUserModel.Properties.email.is(email)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(account: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（账号+密码）"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.account.is(account) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(phone: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（手机号+密码）"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+密码）"
        SFDsLogger.debug(tag: logTag, step: .start, msgs: "")
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.email.is(email) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDsLogger.debug(tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDsLogger.debug(tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signOut() async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func initialPwd(_ pwd: String) async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func resetPwd(_ pwd: String, phone: String, code: String) async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func resetPwd(_ pwd: String, email: String, code: String) async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func getInfo() async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func updateInfo(_ info: [String : Any]) async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
    
    func deleteAccount(pwd: String) async -> SFDataResponse {
        return (code: .ok, isSuccess: true, data: nil, message: nil)
    }
}
