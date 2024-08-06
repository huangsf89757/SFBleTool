source 'https://github.com/CocoaPods/Specs.git'
# 使用frameworks
use_frameworks!
# 忽略pod里面警告
inhibit_all_warnings!
# 支持的平台
platform :ios, '12.0'



# === TARGET === #
target 'SFBleTool' do
  
  # 依赖
  $path = '../../'
  
  # Basic
  pod 'SFBase',         :path => $path + 'Basic/SFBase/'
  pod 'SFExtension',    :path => $path + 'Basic/SFExtension/'
  
  # UI
  pod 'SFUI',           :path => $path + 'UI/SFUI/'
  
  # Server
  pod 'SFLogger',       :path => $path + 'Server/SFLogger/'
  pod 'SFBluetooth',    :path => $path + 'Server/SFBluetooth/'
  
end
