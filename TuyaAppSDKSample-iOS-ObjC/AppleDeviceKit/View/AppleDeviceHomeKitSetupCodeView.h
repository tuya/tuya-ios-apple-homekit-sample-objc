//
//  AppleDeviceHomeKitSetupCodeView.h
//  TuyaAppSDKSample-iOS-ObjC
//
//  Created by 萧然 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleDeviceHomeKitSetupCodeView : UIView

- (void)show;

- (void)hide;

- (void)updateCodeString:(NSString *)codeString;

@end

NS_ASSUME_NONNULL_END
