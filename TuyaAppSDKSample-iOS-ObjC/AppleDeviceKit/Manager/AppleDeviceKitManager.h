//
//  AppleDeviceKitManager.h
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>
#import <TuyaSmartAppleDeviceKit/TuyaSmartAppleDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleDeviceKitManager : NSObject

@property (nonatomic, strong) TuyaSmartHomeKitPermissionUtil *permissionUtil;
@property (nonatomic, strong) TuyaSmartHomeKitUtil *util;
@property (nonatomic, strong) TuyaSmartHomeKitConfigUtil *configUtil;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
