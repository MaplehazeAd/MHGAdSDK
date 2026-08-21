Pod::Spec.new do |s|
  s.name         = 'MHGAdSDK'
  s.version      = '1.0.0'
  s.summary      = 'A local framework for advertisement SDK.'
  s.description  = <<-DESC
    MHAdSDK is a lightweight framework for managing advertisement integrations.
    This is a local framework provided as a static binary.
  DESC
  s.homepage     = 'https://github.com/MaplehazeAd/MHAdSDK'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'MaplehazeAd' => 'rd@maplehaze.cn' }

  # 指定本地的 framework 目录
  s.source       = { :git => 'https://github.com/MaplehazeAd/MHGAdSDK.git', :tag => s.version.to_s }

  # 如果是预编译的 framework
  s.vendored_frameworks = 'MHGAdSDK/MHGAdSDK.xcframework'

  # 支持的最低 iOS 系统版本
  s.platform     = :ios, '13.0'

  # 如果使用 ARC
  s.requires_arc = true
end
