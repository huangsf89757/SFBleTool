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
        let logTag = "获取OptList数据"
        let random = Int.random(in: Self.randomTimeRange)
        SFDpLogger.debug(port: .server ,tag: logTag, step: .begin, msgs: "模拟耗时\(random)秒")
        do {
            try await Task.sleep(nanoseconds: UInt64(random) * 1_000_000_000)
        } catch {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "模拟耗时被中断")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        guard let activeUser = UserModel.active else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "activeUser=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let uid = activeUser.uid else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "uid=nil")
            return (success: false, code: .unauthorized, data: nil, message: nil)
        }
        guard let userDb = SFServerDatabase.getUserDb(with: uid) else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "userDb=nil")
            return (success: false, code: .serverError, data: nil, message: nil)
        }
        let isContains = OptType.codes.contains { code in
            type == code
        }
        guard isContains else {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: "type错误")
            return (success: false, code: .badRequest, data: nil, message: nil)
        }
        do {
            let condition = OptModel.Properties.type.is(type)
            let order = [OptModel.Properties.createTimeL.order(.descending)]
            let models: [OptModel] = try userDb.getObjects(on: OptModel.Properties.all, fromTable: OptModel.table, where: condition, orderBy: order)
            models.forEach { model in
                model.valuesToModels()
            }
            SFDpLogger.debug(port: .server ,tag: logTag, step: .success, msgs: "models.count=\(models.count)")
            return (success: true, code: .ok, data: models, message: nil)
        } catch let error {
            SFDpLogger.debug(port: .server ,tag: logTag, step: .failure, msgs: error.localizedDescription)
            return (success: false, code: .serverError, data: nil, message: nil)
        }
    }
    
    func getDetail(id: String) async -> SFBusiness.SFDataResponse {
        return (success: false, code: .serverError, data: nil, message: nil)
    }
    
    func add(_ opt: [String : Any]) async -> SFBusiness.SFDataResponse {
        return (success: false, code: .serverError, data: nil, message: nil)
    }
    
    func delete(id: String) async -> SFBusiness.SFDataResponse {
        return (success: false, code: .serverError, data: nil, message: nil)
    }    
}
