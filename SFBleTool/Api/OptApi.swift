//
//  OptApi.swift
//  SFBleTool
//
//  Created by hsf on 2024/12/16.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Business
import SFBusiness


// MARK: - OptApi
public protocol OptApi {
    /// 获取列表
    func getList(type: Int) async -> SFDataResponse
    /// 获取详情
    func getDetail(id: String) async -> SFDataResponse
    /// 新增
    func add(_ opt: [String: Any]) async -> SFDataResponse
    /// 删除
    func delete(id: String) async -> SFDataResponse
}

