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
    static let randomTimeRange = 0...6
    
    // MARK: value
    var smsCodes = [String]()
    
}

// MARK: - SFUserApi
extension DbDataProvider: SFUserApi {
    func sendSmsCode(type: SFUser.SmsCodeType) async -> SFDataResponse {
        let logTag = "发送验证码"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        let smsCode = String((0..<6).compactMap { _ in
            "0123456789".randomElement()
        })
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "生成随机验证码", smsCode)
        self.smsCodes.append(smsCode)
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.smsCodes.removeAll { ele in
                ele == smsCode
            }
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "验证码(\(smsCode))过期")
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: smsCode)
        return (code: .ok, isSuccess: true, data: smsCode, message: "验证码发送成功")
    }
    
    func signIn(phone: String, code: String) async -> SFDataResponse {
        let logTag = "登录（手机号+验证码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "user=nil")
                let accounts: [String] = try appDb.getColumn(on: BTUserModel.Properties.account, fromTable: BTUserModel.table).map{ $0.stringValue }
                var newUser = BTUserModel()
                newUser.defaultR()
                newUser.account = BTUserModel.generateUniqueAccount(existingAccounts: Set(accounts))
                newUser.phone = phone
                try appDb.insertOrReplace([newUser], intoTable: BTUserModel.table)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "注册用户", newUser)
                return (code: .ok, isSuccess: true, data: newUser, message: nil)
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, code: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+验证码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        do {
            let condition = BTUserModel.Properties.email.is(email)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "user=nil")
                let accounts: [String] = try appDb.getColumn(on: BTUserModel.Properties.account, fromTable: BTUserModel.table).map{ $0.stringValue }
                var newUser = BTUserModel()
                newUser.defaultR()
                newUser.account = BTUserModel.generateUniqueAccount(existingAccounts: Set(accounts))
                newUser.email = email
                try appDb.insertOrReplace([newUser], intoTable: BTUserModel.table)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "注册用户", newUser)
                return (code: .ok, isSuccess: true, data: newUser, message: nil)
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(account: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（账号+密码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.account.is(account) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(phone: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（手机号+密码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+密码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.email.is(email) && BTUserModel.Properties.pwd.is(pwd)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func signOut() async -> SFDataResponse {
        let logTag = "登出"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .inactive
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func initialPwd(_ pwd: String) async -> SFDataResponse {
        let logTag = "设置初始密码"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.pwd = pwd
                properties.append(.updateTimeR)
                properties.append(.pwd)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func resetPwd(_ pwd: String, phone: String, code: String) async -> SFDataResponse {
        let logTag = "重置密码（手机号+验证码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid) && BTUserModel.Properties.phone.is(phone)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.pwd = pwd
                properties.append(.updateTimeR)
                properties.append(.pwd)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func resetPwd(_ pwd: String, email: String, code: String) async -> SFDataResponse {
        let logTag = "重置密码（邮箱+验证码）"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "smsCode=nil")
            return (code: .ok, isSuccess: false, data: nil, message: "验证码错误")
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid) && BTUserModel.Properties.email.is(email)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.pwd = pwd
                properties.append(.updateTimeR)
                properties.append(.pwd)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func getInfo() async -> SFDataResponse {
        let logTag = "获取用户信息"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func updateInfo(_ info: [String : Any]) async -> SFDataResponse {
        let logTag = "更新用户信息"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                properties.append(.updateTimeR)
                for (key, value) in info {
                    if let mapping = BTUserModel.keyPathMapping[key] {
                        user[keyPath: mapping.keyPath] = value
                        properties.append(mapping.property)
                    } else {
                        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "未知字段: \(key)")
                    }
                }
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
    
    func deleteAccount(pwd: String) async -> SFDataResponse {
        let logTag = "注销账户"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .start, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "模拟耗时被中断")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "activeUser=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "uid=nil")
            return (code: .badRequest, isSuccess: false, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: "appDb=nil")
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if var user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .delete
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: user)
                return (code: .ok, isSuccess: true, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.success), msgs: "user=nil")
                return (code: .ok, isSuccess: true, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .end(.failure), msgs: error.localizedDescription)
            return (code: .serverError, isSuccess: false, data: nil, message: nil)
        }
    }
}
