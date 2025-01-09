//
//  DbOptDataProvider.swift
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
extension DbDataProvider: OptApi {
    func getList(type: Int) async -> SFBusiness.SFDataResponse {
        let logTag = "获取OptList"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .client ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        let uid = activeUser.uid
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "userDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        guard let _ = OptType(code: type) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "type不合法")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        do {
            let condition = OptModel.Properties.type.is(type)
            let order = [OptModel.Properties.createTimeL.order(.descending)]
            let models: [OptModel] = try userDb.getObjects(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition, orderBy: order)
            models.forEach { model in
                model.valuesToModels()
            }
            SFDpLogger.debug(port: .client ,tag: logTag, step: .success, msgs: "models.count=\(models.count)")
            return (success: true, code: .ok, data: models, message: nil)
        } catch let error {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func getDetail(id: String) async -> SFBusiness.SFDataResponse {
        let logTag = "获取OptDetail"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .client ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        let uid = activeUser.uid
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "userDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = OptModel.Properties.idR.is(id)
            let model: OptModel? = try userDb.getObject(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition)
            if let model = model {
                SFDpLogger.debug(port: .client ,tag: logTag, step: .success, msgs: model)
                return (success: true, code: .ok, data: model, message: nil)
            } else {
                SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "model=nil")
                return (success: false, code: .ok, data: nil, message: nil)
            }
        } catch let error {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func add(_ opt: [String : Any]) async -> SFBusiness.SFDataResponse {
        let logTag = "新增Opt"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .client ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        let uid = activeUser.uid
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "userDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        guard let type = opt["type"] as? Int else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "参数必须包含type")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let typeEnum = OptType(code: type) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "type不合法")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let name = opt["name"] as? String else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "参数必须包含name")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        let model = OptModel()
        model.typeEnum = typeEnum
        model.name = name
        if let itemValues = opt["itemValues"] as? [Int: String] {
            model.itemValues = itemValues
        }
        do {
            try userDb.insertOrReplace([model], intoTable: OptModel.table)
            SFDpLogger.debug(port: .client ,tag: logTag, step: .success, msgs: model)
            return (success: true, code: .ok, data: nil, message: nil)
        } catch let error {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func delete(id: String) async -> SFBusiness.SFDataResponse {
        let logTag = "删除Opt"
        let random = Double.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .client ,tag: logTag, step: .begin, msgs: String(format: "模拟耗时%.2f秒", random))
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        let uid = activeUser.uid
        guard let userDb = SFClientDatabase.getUserDb(with: uid) else {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: "userDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        do {
            let condition = OptModel.Properties.idR.is(id)
            try userDb.delete(fromTable: OptModel.table, where: condition)
            SFDpLogger.debug(port: .client ,tag: logTag, step: .success, msgs: "")
            return (success: true, code: .ok, data: nil, message: nil)
        } catch let error {
            SFDpLogger.debug(port: .client ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
}
