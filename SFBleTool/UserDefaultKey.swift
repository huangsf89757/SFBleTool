//
//  UserDefaultKey.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
//

import Foundation

struct UserDefaultKey {
    private static let perfix = "SF_KEY_"
    
    /// 是否已经完成内置数据
    static let buildInData = perfix + "buildInData"
}
