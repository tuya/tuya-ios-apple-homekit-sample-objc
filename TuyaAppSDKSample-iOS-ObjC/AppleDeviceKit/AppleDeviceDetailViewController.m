//
//  AppleDeviceDetailViewController.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "AppleDeviceDetailViewController.h"
#import "Home.h"
#import "Alert.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "AppleDeviceHomeKitSetupCodeView.h"

@interface AppleDeviceDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *reachableLabel;
@property (weak, nonatomic) IBOutlet UILabel *bridgedLabel;
@property (weak, nonatomic) IBOutlet UILabel *isTuyaDeviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *devIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *productIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *UUIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (weak, nonatomic) IBOutlet UILabel *acticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeKitCodeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bindButton;

@property (nonatomic, strong) AppleDeviceHomeKitSetupCodeView *codeView;

@end

@implementation AppleDeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Device Info";
    [self setDeviceInfo];
}

- (void)setDeviceInfo {
    // basic info
    self.reachableLabel.text = self.device.reachable ? @"YES" : @"NO";
    self.bridgedLabel.text = self.device.bridged ? @"YES" : @"NO";
    self.isTuyaDeviceLabel.text = self.device.isTuyaDevice ? @"YES" : @"NO";
    
    // tuya custom characteristics
    [self.device updateWithCompletionHandler:^(NSError * _Nullable error) {
        self.devIdLabel.text = [NSString stringWithFormat:@"%@", self.device.devId.value];
        self.productIDLabel.text = [NSString stringWithFormat:@"%@", self.device.productID.value];
        self.UUIDLabel.text = [NSString stringWithFormat:@"%@", self.device.UUID.value];
        self.tokenLabel.text = [NSString stringWithFormat:@"%@", self.device.token.value];
        self.acticeLabel.text = [self.device.active.value boolValue] ? NSLocalizedString(@"binded", @"") : NSLocalizedString(@"unBound", @"");
        self.bindButton.title = [self.device.active.value boolValue] ? NSLocalizedString(@"binded", @"") : NSLocalizedString(@"bind", @"");
    }];
    
    [self requestHomeKitSetupCode];
}

#pragma mark - request
- (void)requestHomeKitSetupCode {
    // request homekit setup code
    [TuyaSmartHomeKitDeviceService requestDeviceHomeKitSetupCodeWithDeviceId:self.device.devId.value success:^(TuyaSmartHomeKitSetupCodeInfo * _Nonnull info) {
        self.homeKitCodeLabel.text = info.homeKitSetupCode;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView reloadData];
    }];
}

#pragma mark - button clicked
- (IBAction)bindDeviceToTuyaCloud:(id)sender {
    if ([self.device.active.value boolValue]) {
        [Alert showBasicAlertOnVC:self withTitle:@"device has been binded" message:@""];
        return;
    }
    [SVProgressHUD show];
    long long homeId = Home.getCurrentHome.homeId;
    [[AppleDeviceKitManager sharedInstance].configUtil startConfigDevice:self.device timeout:120 homeId:homeId success:^(TuyaSmartDeviceModel * _Nonnull deviceModel) {
        [SVProgressHUD dismiss];
        [Alert showBasicAlertOnVC:self withTitle:@"congratulation！" message:@"bind success!!!"];
        // bind success
        [self setDeviceInfo];

    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [Alert showBasicAlertOnVC:self withTitle:@"bind error" message:error.localizedDescription];
    }];
}

#pragma mark - cell clicked
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self addDeviceToHomekitWithDisplayingHomeKitSetupCode];
    }
}

- (void)addDeviceToHomekitWithDisplayingHomeKitSetupCode {
    
    //    if ([self correspondenceHomeKitDevice]) {
    //        [Alert showBasicAlertOnVC:self withTitle:@"" message:@"device has been added!"];
    //        return;
    //    }
        
    [[AppleDeviceKitManager sharedInstance].permissionUtil checkHomeKitPermissionWithCompletionHandler:^(BOOL granted, HMHomeManager * _Nullable manager) {
        if (!granted) {
            [Alert showBasicAlertOnVC:self withTitle:@"error" message:@"NO HomeKit Permission!"];
            return;
        }
        
        // Here is a simulated display of the HomeKit setup code when adding device.
        // It is actually to be used for device that is binded to Tuya Cloud but not added to home.
        
        if (!self.homeKitCodeLabel.text.length) {
            [Alert showBasicAlertOnVC:self withTitle:@"Please bind the device to get code!" message:@""];
            return;
        }
        // has code
        NSString *homeKitSetupCodeString = [NSString stringWithFormat:@"%@：%@", NSLocalizedString(@"homekit_device_code", @""), self.homeKitCodeLabel.text];
        [[AppleDeviceKitManager sharedInstance].util addAccessoryToPrimaryHomeWithSetupViewControllerDidLoadHandler:^{
            self.codeView = [[AppleDeviceHomeKitSetupCodeView alloc] initWithFrame:CGRectZero];
            [self.codeView updateCodeString:homeKitSetupCodeString];
            [self.codeView show];
        } completionHandler:^(NSError * _Nullable error) {
            [self.codeView hide];
            self.codeView = nil;
            if (!error) {
                // accessory add successed.
            }
        }];
    }];
}

- (TuyaSmartHomeKitDevice *)correspondenceHomeKitDevice {
 
    __block TuyaSmartHomeKitDevice *homeKitDevice = nil;
    [[[AppleDeviceKitManager sharedInstance].util devices] enumerateObjectsUsingBlock:^(TuyaSmartHomeKitDevice * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.UUID isEqual:self.device.UUID]) {
            homeKitDevice = obj;
            *stop = YES;
        }
    }];

    return homeKitDevice;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
