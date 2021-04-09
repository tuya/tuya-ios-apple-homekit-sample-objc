source 'https://cdn.cocoapods.org/'
source 'https://github.com/TuyaInc/TuyaPublicSpecs.git'

target 'TuyaAppSDKSample-iOS-ObjC' do
  pod 'Masonry'
  pod 'SVProgressHUD'
  pod 'SDWebImage/Core','4.4.3'
  pod 'TuyaSmartHomeKit'
  pod 'TuyaSmartAppleDeviceKit', '1.0.0'
end

post_install do |installer|
  `cd TuyaAppSDKSample-iOS-ObjC; [[ -f AppKey.h ]] || cp AppKey.h.default AppKey.h;`
end
