# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
         end
    end
  end
end

def is_pod_binary_cache_enabled
  ENV['IS_POD_BINARY_CACHE_ENABLED'] == 'true'
end

if is_pod_binary_cache_enabled
  plugin 'cocoapods-binary-cache'
  config_cocoapods_binary_cache(
    cache_repo: {
      "default" => {
        "local" => "~/.cocoapods-binary-cache/FunnyRingtones-lib"
      }
    },
    prebuild_config: "Debug",
    device_build_enabled: true,
    xcframework: true,
    bitcode_enabled: true
  )
end

def binary_pod(name, *args)
  if is_pod_binary_cache_enabled
    pod name, args, :binary => true
  else
    pod name, args
  end
end

target 'LovelyMusic' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LovelyMusic
binary_pod 'RxSwift'
  binary_pod 'RxCocoa'
  binary_pod 'SwiftyAttributes'
  binary_pod 'IQKeyboardManager'
  binary_pod 'Alamofire'
  pod 'RealmSwift', '10.23.0'
  binary_pod 'ReachabilitySwift'
  binary_pod 'SDWebImage'
  binary_pod 'Cache'
  binary_pod 'SVProgressHUD'
  binary_pod 'Resolver'
  binary_pod 'lottie-ios'
  pod 'SDAVAssetExportSession', :git => 'https://github.com/rs/SDAVAssetExportSession.git'
binary_pod 'Firebase/Crashlytics'

end
