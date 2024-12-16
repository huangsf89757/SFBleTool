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
    static let randomTimeRange: ClosedRange<Double> = 1...5
    
    // MARK: value
    var smsCodes = [String]()
    
}


