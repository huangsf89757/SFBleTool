source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!
platform :ios, '14.0'

##################
#      PODS      #
##################

# === 私有组件 === #
def pods_private
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
  pod 'SFBusiness',       :path => $root + $business + 'SFBusiness/'
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

target 'SFBleTool' do
  pods_private
  pods_third
end

##################
#      COLOR     #
##################
COLOR_RED = "\033[0;31m"
COLOR_GREEN = "\033[0;32m"
COLOR_YELLOW = "\033[0;33m"
COLOR_BLUE = "\033[0;34m"
COLOR_PURPLE = "\033[0;35m"
COLOR_CYAN = "\033[0;36m"
COLOR_RESET = "\033[0m"

def colorize(color, text)
  puts "#{color}#{text}#{COLOR_RESET}"
end

##################
#      HOOK      #
##################

pre_install do |installer|
  colorize(COLOR_BLUE, ">>>>>>>>>>> pre_install [开始] <<<<<<<<<<<<")
  colorize(COLOR_GREEN, ">>>>>>>>>>> pre_install [结束] <<<<<<<<<<<<")
end

post_install do |installer|
  colorize(COLOR_BLUE, ">>>>>>>>>>> post_install [开始] <<<<<<<<<<<<")

  set_localization(installer)
  set_configurations(installer)
  set_team(installer)

  colorize(COLOR_GREEN, ">>>>>>>>>>> post_install [结束] <<<<<<<<<<<<")
end

##################
#      FUNC      #
##################
require 'xcodeproj'

def get_main_project_localizations()
  project_path = "./SFBleTool.xcodeproj"
  unless File.exist?(project_path)
    raise "主工程路径无效：#{project_path}"
  end

  unless project_path.end_with?('.xcodeproj')
    raise "提供的路径不是一个有效的 Xcode 工程文件：#{project_path}"
  end

  begin
    project = Xcodeproj::Project.open(project_path)
  rescue => e
    raise "打开工程失败：#{e.message}"
  end

  root_object = project.root_object
  known_regions = root_object.known_regions
  if known_regions.nil? || known_regions.empty?
    colorize(COLOR_YELLOW, "警告：主工程未设置 knownRegions 或没有 Localizations。")
    return []
  end
  
  colorize(COLOR_GREEN, "主工程的 knownRegions: #{known_regions.join(', ')}")
  
  localizations = known_regions.reject { |region| region == 'Base' }
  localizations
end


# 设置 Localizations 和 Default Language
def set_localization(installer)
  colorize(COLOR_BLUE, "set_localization [开始]")

  localizations = get_main_project_localizations()
  if localizations.empty?
    colorize(COLOR_YELLOW, "警告：未找到 Localizations，跳过设置。")
    return
  end

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEVELOPMENT_LANGUAGE'] = localizations.first
    end
  end

  colorize(COLOR_GREEN, "set_localization [成功]")
end


# 设置 configurations
def set_configurations(installer)
  colorize(COLOR_BLUE, "set_configurations [开始]")
  
  pods_project = installer.pods_project
  
  pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['GCC_OPTIMIZATION_LEVEL'] = 's'
      config.build_settings['OTHER_SWIFT_FLAGS'] ||= ''
      
      # 检查是否已经包含调试标志
      unless config.build_settings['OTHER_SWIFT_FLAGS'].include?('-DDEBUG')
        config.build_settings['OTHER_SWIFT_FLAGS'] += ' -DDEBUG'
      end
    end
  end

  colorize(COLOR_GREEN, "set_configurations [成功]")
end



# 设置 Team
def set_team(installer)
  colorize(COLOR_BLUE, "set_team [开始]")

  main_project = installer.aggregate_targets[0].user_project
  pods_project = installer.pods_project
  
  # 获取主工程的开发团队 ID
  dev_team = ""
  main_project.targets.each do |target|
    target.build_configurations.each do |config|
      dev_team = config.build_settings['DEVELOPMENT_TEAM'] if dev_team.empty?
    end
  end
  
  # 仅为需要代码签名的 Pods 目标设置开发团队
  pods_project.targets.each do |target|
    next unless target.product_type == "com.apple.product-type.bundle" # 仅处理 Bundle 类型
    target.build_configurations.each do |config|
      config.build_settings['DEVELOPMENT_TEAM'] = dev_team
    end
  end

  colorize(COLOR_GREEN, "set_team [成功]")
end

  


