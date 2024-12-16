//
//  DbUserDataProvider.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/16.
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

// MARK: - SFUserApi
extension DbDataProvider: SFUserApi {
    func sendSmsCode(type: SFUser.SmsCodeType) async -> SFDataResponse {
        let logTag = "发送验证码"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
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
            SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: "验证码(\(smsCode))过期")
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: smsCode)
        return (success: true, code: .ok, data: smsCode, message: "验证码发送成功")
    }
    
    func signIn(phone: String, code: String) async -> SFDataResponse {
        let logTag = "登录（手机号+验证码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "smsCode=nil")
            return (success: false, code: .ok, data: nil, message: "验证码错误")
        }
        self.smsCodes.removeAll { ele in
            ele == smsCode
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "user=nil")
                let accounts: [String] = try appDb.getColumn(on: BTUserModel.Properties.account, fromTable: BTUserModel.table).map{ $0.stringValue }
                let newUser = BTUserModel()
                newUser.defaultR()
                newUser.account = BTUserModel.generateUniqueAccount(existingAccounts: Set(accounts))
                newUser.phone = phone
                try appDb.insertOrReplace([newUser], intoTable: BTUserModel.table)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: "注册新用户", newUser)
                return (success: true, code: .ok, data: newUser, message: nil)
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, code: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+验证码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "smsCode=nil")
            return (success: false, code: .ok, data: nil, message: "验证码错误")
        }
        self.smsCodes.removeAll { ele in
            ele == smsCode
        }
        do {
            let condition = BTUserModel.Properties.email.is(email)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .active
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: "user=nil")
                let accounts: [String] = try appDb.getColumn(on: BTUserModel.Properties.account, fromTable: BTUserModel.table).map{ $0.stringValue }
                let newUser = BTUserModel()
                newUser.defaultR()
                newUser.account = BTUserModel.generateUniqueAccount(existingAccounts: Set(accounts))
                newUser.email = email
                try appDb.insertOrReplace([newUser], intoTable: BTUserModel.table)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: "注册新用户", newUser)
                return (success: true, code: .ok, data: newUser, message: nil)
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func signIn(account: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（账号+密码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.account.is(account)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                if user.pwd == pwd {
                    var properties = [BTUserModel.Properties]()
                    user.updateDateR = Date()
                    user.stateEnum = .active
                    properties.append(.updateTimeR)
                    properties.append(.state)
                    try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                    return (success: true, code: .ok, data: user, message: nil)
                } else {
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "密码不正确")
                    return (success: false, code: .ok, data: nil, message: "密码不正确")
                }
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func signIn(phone: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（手机号+密码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.phone.is(phone)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                if user.pwd == pwd {
                    var properties = [BTUserModel.Properties]()
                    user.updateDateR = Date()
                    user.stateEnum = .active
                    properties.append(.updateTimeR)
                    properties.append(.state)
                    try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                    return (success: true, code: .ok, data: user, message: nil)
                } else {
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "密码不正确")
                    return (success: false, code: .ok, data: nil, message: "密码不正确")
                }
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func signIn(email: String, pwd: String) async -> SFDataResponse {
        let logTag = "登录（邮箱+密码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.email.is(email)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                if user.pwd == pwd {
                    var properties = [BTUserModel.Properties]()
                    user.updateDateR = Date()
                    user.stateEnum = .active
                    properties.append(.updateTimeR)
                    properties.append(.state)
                    try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                    return (success: true, code: .ok, data: user, message: nil)
                } else {
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "密码不正确")
                    return (success: false, code: .ok, data: nil, message: "密码不正确")
                }
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func signOut() async -> SFDataResponse {
        let logTag = "登出"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .inactive
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func initialPwd(_ pwd: String) async -> SFDataResponse {
        let logTag = "设置初始密码"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.pwd = pwd
                properties.append(.updateTimeR)
                properties.append(.pwd)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func resetPwd(_ pwd: String, phone: String, code: String) async -> SFDataResponse {
        let logTag = "重置密码（手机号+验证码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "smsCode=nil")
            return (success: false, code: .ok, data: nil, message: "验证码错误")
        }
        self.smsCodes.removeAll { ele in
            ele == smsCode
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                if let userPhone = user.phone {
                    if userPhone == phone {
                        var properties = [BTUserModel.Properties]()
                        user.updateDateR = Date()
                        user.pwd = pwd
                        properties.append(.updateTimeR)
                        properties.append(.pwd)
                        try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                        SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                        return (success: true, code: .ok, data: user, message: nil)
                    } else {
                        SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "手机号不正确")
                        return (success: false, code: .ok, data: nil, message: "请使用该账号当前绑定的手机号")
                    }
                } else {
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "未绑定手机号")
                    return (success: false, code: .ok, data: nil, message: "该账号未绑定手机号，请尝试其他方式重置密码")
                }
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func resetPwd(_ pwd: String, email: String, code: String) async -> SFDataResponse {
        let logTag = "重置密码（邮箱+验证码）"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        let smsCode = self.smsCodes.first { ele in
            ele == code
        }
        guard let smsCode = smsCode else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "smsCode=nil")
            return (success: false, code: .ok, data: nil, message: "验证码错误")
        }
        self.smsCodes.removeAll { ele in
            ele == smsCode
        }
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                if let userEmail = user.email {
                    if userEmail == email {
                        var properties = [BTUserModel.Properties]()
                        user.updateDateR = Date()
                        user.pwd = pwd
                        properties.append(.updateTimeR)
                        properties.append(.pwd)
                        try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                        SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                        return (success: true, code: .ok, data: user, message: nil)
                    } else {
                        SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "邮箱不正确")
                        return (success: false, code: .ok, data: nil, message: "请使用该账号当前绑定的邮箱")
                    }
                } else {
                    SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "未绑定邮箱")
                    return (success: false, code: .ok, data: nil, message: "该账号未绑定邮箱，请尝试其他方式重置密码")
                }
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func getInfo() async -> SFDataResponse {
        let logTag = "获取用户信息"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func updateInfo(_ info: [String : Any]) async -> SFDataResponse {
        let logTag = "更新用户信息"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
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
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func deleteAccount(pwd: String) async -> SFDataResponse {
        let logTag = "注销账户"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        SFDpLogger.debug(port: .server ,tag: logTag, step: .inProcess, msgs: activeUser)
        guard let appDb = SFServerDatabase.getAppDb() else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "appDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = BTUserModel.Properties.uid.is(uid)
            let user: BTUserModel? = try appDb.getObject(on: BTUserModel.Properties.all, fromTable: BTUserModel.table, where: condition)
            if let user = user {
                var properties = [BTUserModel.Properties]()
                user.updateDateR = Date()
                user.stateEnum = .delete
                properties.append(.updateTimeR)
                properties.append(.state)
                try appDb.update(table: BTUserModel.table, on: properties, with: user, where: condition)
                SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: user)
                return (success: true, code: .ok, data: user, message: nil)
            } else {
                SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "user=nil")
                return (success: false, code: .ok, data: nil, message: "用户不存在")
            }
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
}
