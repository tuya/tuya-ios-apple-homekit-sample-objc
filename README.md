# Tuya Apple HomeKit Sample for Objective-C

This sample describes how to quickly integrate HomeKit functionality by using an SDK. The TuyaSmartAppleDeviceKit module allows you to manage HomeKit data from Apple's 'Home' app and bind Apple devices directly to the Tuya Cloud. The module features faster integration with the Apple HomeKit framework. A simple interface is provided for you to bind devices to the Tuya Cloud and get device information.

To support HomeKit in your projects, perform the following steps:
-  Add an NSHomeKitUsageDescription key with a string value in the app's Info.plist that explains how the app uses this data.
- Add the HomeKit capability. HomeKit can be used to connect your app to HomeKit accessories and create home configurations.

A HomeKit-enabled Tuya device is required.

<img src="https://airtake-public-data-1254153901.cos.ap-shanghai.myqcloud.com/goat/20210402/88f33970589646d1af4d868909cac1af.png" width="30%" />

## Prerequisites

- Xcode 12.0 and later
- iOS 12 and later

## Use the sample

1. The Tuya iOS HomeSDK is distributed based on [CocoaPods](http://cocoapods.org/) and other dependencies in this sample. Make sure that you have installed CocoaPods. If not, run the following command to install CocoaPods first:

```bash
sudo gem install cocoapods
pod setup
```
**Note:** Make sure that this spec source is added to your podfile. The spec of `TuyaSmartAppleDeviceKit` is only uploaded to this spec source.
```ruby
source 'https://registry.code.tuya-inc.top/tuyaIOS/TYSpecs.git'
```

2. Clone or download this sample, change the directory to the one that includes **Podfile**, and then run the following command:

```bash
pod install
```

1. This sample requires you to have a pair of keys and a security image from [Tuya IoT Platform](https://iot.tuya.com/), and register a developer account if you do not have one. Then, perform the following steps:

   1. Log in to the [Tuya IoT platform](https://iot.tuya.com//). In the left-side navigation pane, choose **App** > **SDK Development**.
   2. Click **Create** to create an app.
   3. Fill in the required information. Make sure that you enter the valid Bundle ID. It cannot be changed afterward.
   4. You can find the AppKey, AppSecret, and security image under the **Obtain Key** tag.

2. Open the `TuyaAppSDKSample-iOS-ObjC.xcworkspace` pod that is generated for you.
3. Enter the AppKey and AppSecret in the **AppKey.h** file.

```objective-c
#define APP_KEY @"<#AppKey#>"
#define APP_SECRET_KEY @"<#SecretKey#>"
```

6. Download the security image, rename it to `t_s.bmp`, and then drag it to the workspace to be at the same level as `Info.plist`.

**Note**: The bundle ID, AppKey, AppSecret, and security image must be the same as your app on the [Tuya IoT Platform](https://iot.tuya.com). Otherwise, the sample cannot request the API.

## References
For more information about Tuya iOS HomeSDK, see [App SDK](https://developer.tuya.com/en/docs/app-development).
