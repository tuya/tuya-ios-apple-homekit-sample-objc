# Tuya Apple HomeKit Sample for Objective-C

This sample demonstrates how to quickly integrate HomeKit functionality via SDK. You will know how to use the SDK through this sample, which mainly includes HomeKit data loading, data updating, device adding and device binding to the cloud. Of course you can also see the characteristics of Tuya that support Apple HomeKit devices.

If you want to support HomeKit in your own projects, you must complete two steps in advance:
-  Add an NSHomeKitUsageDescription key with a string value in the app's Info.plist explaining to the user how the app uses this data.
- Add HomeKit capability to enabling HomeKit allows your app interact with HomeKit accessories and create home configrations.

You need to have a HomeKit-enabled Tuya device.

<img src="https://github.com/tuya/tuya-ios-apple-homekit-sample-objc/blob/master/screenshot.png" width="30%" />

## Prerequisites

- Xcode 12.0 and later
- iOS 12 and later

## Use the sample

1. The Tuya iOS HomeSDK is distributed through [CocoaPods](http://cocoapods.org/) and other dependencies in this sample. Make sure that you have installed CocoaPods. If not, run the following command to install CocoaPods first:

```bash
sudo gem install cocoapods
pod setup
```

2. Clone or download this sample, change the directory to the one that includes **Podfile**, and then run the following command:

```bash
pod install
```

3. This sample requires you to have a pair of keys and a security image from [Tuya IoT Platform](https://developer.tuya.com/), and register a developer account if you don't have one. Then, perform the following steps:

   1. Log in to the [Tuya IoT platform](https://iot.tuya.com/). In the left-side navigation pane, choose **App** > **SDK Development**.
   2. Click **Create** to create an app.
   3. Fill in the required information. Make sure that you enter the valid Bundle ID. It cannot be changed afterward.
   4. You can find the AppKey, AppSecret, and security image under the **Obtain Key** tag.

4. Open the `TuyaAppSDKSample-iOS-ObjC.xcworkspace` pod generated for you.
5. Fill in the AppKey and AppSecret in the **AppKey.h** file.

```objective-c
#define APP_KEY @"<#AppKey#>"
#define APP_SECRET_KEY @"<#SecretKey#>"
```

6. Download the security image, rename it to `t_s.bmp`, and then drag it to the workspace to be at the same level as `Info.plist`.

**Note**: The bundle ID, AppKey, AppSecret, and security image must be the same as your app on the [Tuya IoT Platform](https://iot.tuya.com). Otherwise, the sample cannot request the API.

## References
For more information about Tuya iOS HomeSDK, see [App SDK](https://developer.tuya.com/en/docs/app-development).
