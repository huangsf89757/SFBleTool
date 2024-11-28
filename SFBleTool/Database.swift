//
//  Database.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/28.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness
import SFUser
// Server
import SFLogger

extension AppDelegate {
    func configAppDatabase() {
        guard let appDb = SFDatabase.appDb else { return }
        do {
            try appDb.create(table: UserModel.tableName, of: UserModel.self)
        } catch let error {
            SFLogger.debug("[DB]", "建表失败", error.localizedDescription)
        }
    }
}
