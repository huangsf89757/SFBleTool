source 'https://github.com/CocoaPods/Specs.git'
# 使用frameworks
use_frameworks!
# 忽略pod里面警告
inhibit_all_warnings!
# 支持的平台
platform :ios, '12.0'


##################
#      PODS      #
##################

# === 私有组件 === #
def pods_private
  # 本地路径
  $path = '../../'
  
  # Basic
  pod 'SFBase',         :path => $path + 'Basic/SFBase/'
  pod 'SFExtension',    :path => $path + 'Basic/SFExtension/'
  pod 'SFBluetooth',    :path => $path + 'Basic/SFBluetooth/'
  
  
  # UI
  pod 'SFUI',           :path => $path + 'UI/SFUI/'
  
  # Server
  pod 'SFLogger',       :path => $path + 'Server/SFLogger/'
 
 
end

# === 第三方组件 === #
def pods_third
  
  pod 'R.swift',          '~> 7.3.2'
  pod 'SideMenu',         '~> 6.5.0'
  pod 'WSTagsField',      '~> 5.4.0'
  pod "WARangeSlider",    '~> 1.2.0'
  
end


##################
#     TARGET     #
##################

# === SFBleTool === #
target 'SFBleTool' do
  
  pods_private
  pods_third
  
end
