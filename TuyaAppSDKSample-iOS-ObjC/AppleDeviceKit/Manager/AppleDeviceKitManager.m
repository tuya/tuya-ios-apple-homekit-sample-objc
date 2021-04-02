//
//  AppleDeviceKitManager.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "AppleDeviceKitManager.h"

@implementation AppleDeviceKitManager

+ (instancetype)sharedInstance {
    static AppleDeviceKitManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.permissionUtil = [[TuyaSmartHomeKitPermissionUtil alloc] init];
        self.util = [[TuyaSmartHomeKitUtil alloc] init];
        self.configUtil = [[TuyaSmartHomeKitConfigUtil alloc] init];
    }
    return self;
}

@end
