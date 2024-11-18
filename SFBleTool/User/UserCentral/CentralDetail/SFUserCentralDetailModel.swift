//
//  SFUserCentralDetailModel.swift
//  SFBleTool
//
//  Created by hsf on 2024/9/16.
//

import Foundation
import CoreBluetooth


// MARK: - SFUserCentralDetailModel
class SFUserCentralDetailModel {
    // # InitializationOption
    /// 当蓝牙服务不可用时，如果应用实例化中央管理器，系统是否警告用户。
    var isShowPowerAlert: Bool = true
    
    /// 中央管理器要实例化的唯一标识符（UID）。
    /// 系统使用此UID标识特定的中央管理器。因此，UID必须保持不变，以便后续执行应用程序来恢复中央管理器。
    var restoreIdentifier: String?
    
    // # ScanningOption
    /// 是否应在不进行重复筛选的情况下运行扫描。
    /// 如果 `true` ，则中心禁用过滤，并在每次从外围设备接收通告数据包时生成发现事件。
    /// 如果 `false` （默认值），则中心将同一外围设备的多个发现合并为单个发现事件。
    var isAllowDuplicates: Bool = false
    
    /// 要扫描的服务 UUID 数组。
    /// 指定此扫描选项会导致中央管理器还扫描请求阵列中包含的任何服务的外围设备。
    var solicitedServiceUUIDs: [CBUUID]?
    
    // # ConnectionOption
    /// 系统是否自动重新连接到外围设备。
    /// 外围设备连接后，此设置使系统能够在链路断开时自动启动与对等设备的连接。
    /// 系统用于 `centralManager(_:didDisconnectPeripheral:timestamp:isReconnecting:error:)` 通知呼叫者断开连接。
    var isEnableAutoReconnect: Bool?
    
    /// 桥接经典蓝牙技术配置文件。
    /// 如果与同一设备有低功耗的 GATT 连接，此选项会告诉系统在经典蓝牙设备上连接非 GATT 配置文件。
    /// `true` 值指示系统在连接低能耗传输外围设备时调出经典传输配置文件。
    /// `false` 值告诉系统不要使用配置文件
    var isEnableTransportBridging: Bool?
    
    /// 指定系统在后台连接外围设备时是否应显示警报。
    /// 此键对于未指定 `bluetooth-central` 后台模式且无法显示自己的警报的应用非常有用。
    /// 如果多个应用请求给定外围设备的通知，则最近处于前台的外围设备将收到警报。
    /// 如果未指定键，则默认值为 `false`。
    var isNotifyOnConnection: Bool = false
    
    /// 指定在后台断开外围设备连接时系统是否应显示警报。
    /// 此键对于未指定 `bluetooth-central` 后台模式且无法显示自己的警报的应用非常有用。
    /// 如果多个应用请求给定外围设备的通知，则最近处于前台的外围设备将收到警报。
    /// 如果未指定键，则默认值为 `false`。
    var isNotifyOnDisconnection: Bool = false
    
    /// 指定系统是否应针对外围设备发送的任何通知显示警报。
    /// 此键对于未指定 `bluetooth-central` 后台模式且无法显示自己的警报的应用非常有用。
    /// 如果多个应用请求给定外围设备的通知，则最近处于前台的外围设备将收到警报。
    /// 如果未指定键，则默认值为 `false`。
    /// 如果 `true` 为 ，则系统会针对应用挂起时从给定外围设备接收的所有通知显示警报。
    var isNotifyOnNotification: Bool = false
    
    /// 连接设备时是否需要Apple通知中心服务（ANCS）。
    var isRequiresANCS: Bool?
    
    /// 指示系统建立连接之前的延迟时间。
    var startDelay: TimeInterval?
    
}

