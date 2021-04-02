#source 'https://cdn.cocoapods.org/'
#source 'https://github.com/TuyaInc/TuyaPublicSpecs.git'
source 'https://cocoapods.tuya-inc.top:7799/'
source 'https://registry.code.tuya-inc.top/tuyaIOS/TYSpecs.git'

target 'TuyaAppSDKSample-iOS-ObjC' do
  pod 'Masonry'
  pod 'SVProgressHUD'
  pod 'SDWebImage/Core','4.4.3'
  pod 'TuyaSmartHomeKit'
  pod 'TuyaSmartAppleDeviceKit', '1.0.0-rc8'
end

post_install do |installer|
  `cd TuyaAppSDKSample-iOS-ObjC; [[ -f AppKey.h ]] || cp AppKey.h.default AppKey.h;`
end
