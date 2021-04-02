//
//  AppleDeviceUIModel.h
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <Foundation/Foundation.h>
#import <TuyaSmartAppleDeviceKit/TuyaSmartHomeKitDevice.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleDeviceUIModel : NSObject

@property (nonatomic, strong) TuyaSmartHomeKitDevice *homekitDevice;

@property (copy, nonatomic)  NSString *name;

@property (copy, nonatomic)  NSString *icon;

- (instancetype)initWithHomekitDevice:(TuyaSmartHomeKitDevice *)homeKitDevice;

@end

NS_ASSUME_NONNULL_END
