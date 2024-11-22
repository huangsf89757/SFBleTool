source 'https://github.com/CocoaPods/Specs.git'
# 使用frameworks
use_frameworks!
# 忽略pod里面警告
inhibit_all_warnings!
# 支持的平台
platform :ios, '14.0'


##################
#      PODS      #
##################

# === 私有组件 === #
def pods_private
  # 本地路径
  $root = '../../'
  $basic = 'Basic/'
  $ui = 'UI/'
  $business = 'Business/'
  $server = 'Server/'
  
  # Basic
  pod 'SFBase',           :path => $root + $basic + 'SFBase/'
  pod 'SFExtension',      :path => $root + $basic + 'SFExtension/'
  
  # UI
  pod 'SFUI',             :path => $root + $ui + 'SFUI/'
  
  # Business
  pod 'SFBusiness',           :path => $root + $business + 'SFBusiness/'
  pod 'SFUser',           :path => $root + $business + 'SFUser/'
    
  # Server
  pod 'SFLogger',         :path => $root + $server + 'SFLogger/'
  pod 'SFBluetooth',      :path => $root + $server + 'SFBluetooth/'
 
 
end

# === 第三方组件 === #
def pods_third
  
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
