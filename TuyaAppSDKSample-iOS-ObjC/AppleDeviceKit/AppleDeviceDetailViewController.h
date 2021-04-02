//
//  AppleDeviceDetailViewController.h
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleDeviceDetailViewController : UITableViewController

@property (nonatomic, strong) TuyaSmartHomeKitDevice *device;

@end

NS_ASSUME_NONNULL_END
