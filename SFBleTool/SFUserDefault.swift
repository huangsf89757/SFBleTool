//
//  SFUserDefault.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
//

import Foundation
// Basic
import SFBase

extension SFUserDefault {
    private static let key_buildInData = perfixKey + "buildInData"
    /// 是否内建数据
    public static var buildInData: Bool {
        get {
            return standard.bool(forKey: key_buildInData)
        }
        set {
            standard.setValue(newValue, forKey: key_buildInData)
        }
    }
}
