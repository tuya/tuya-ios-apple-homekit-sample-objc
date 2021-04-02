//
//  AppleDeviceUIModel.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "AppleDeviceUIModel.h"

@implementation AppleDeviceUIModel

- (instancetype)initWithHomekitDevice:(TuyaSmartHomeKitDevice *)homeKitDevice {
    if (self = [super init]) {
        self.homekitDevice = homeKitDevice;
    }
    return self;
}

@end
