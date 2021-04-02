//
//  AppleDeviceListViewController.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "AppleDeviceListViewController.h"
#import "AppleDeviceDetailViewController.h"

@interface AppleDeviceListViewController ()

@property (nonatomic, strong) NSMutableArray<AppleDeviceUIModel *> *devices;

@end

@implementation AppleDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.home.name;
    [self reloadDevices];
}

- (void)reloadDevices {
    self.devices = [NSMutableArray array];
    NSArray *homeKitDevices = [[AppleDeviceKitManager sharedInstance].util devicesForHome:self.home];
    for (TuyaSmartHomeKitDevice *homeKitDevice in homeKitDevices) {
        AppleDeviceUIModel *deviceUIModel = [[AppleDeviceUIModel alloc] initWithHomekitDevice:homeKitDevice];
        [self.devices addObject:deviceUIModel];
    }
    [self.tableView reloadData];
}

- (IBAction)addDeviceToHome:(id)sender {
    [[AppleDeviceKitManager sharedInstance].util addAccessoryToHome:self.home completionHandler:^(NSError * _Nullable error) {
        if (!error) {
            [self reloadDevices];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"apple-device-cell" forIndexPath:indexPath];
    AppleDeviceUIModel *device = self.devices[indexPath.row];
    cell.textLabel.text = device.homekitDevice.accessory.name;
    NSString *productID = device.homekitDevice.productID.value;
    NSString *uuid = device.homekitDevice.UUID.value;
    [TuyaSmartHomeKitDeviceService requestProductInfoWithProductId:productID uuid:uuid success:^(TuyaSmartHomeKitProductInfo * _Nonnull info) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:info.iconURL] placeholderImage:[UIImage imageNamed:@"ty_device_empty"]];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppleDeviceUIModel *device = self.devices[indexPath.row];
        [[AppleDeviceKitManager sharedInstance].util removeAccessory:device.homekitDevice.accessory fromHome:self.home completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                [self reloadDevices];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppleDeviceUIModel *device = self.devices[indexPath.row];
    [self performSegueWithIdentifier:@"show-apple-device-detail" sender:device];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.identifier isEqualToString:@"show-apple-device-detail"]) {
        return;
    }
    
    if (![sender isKindOfClass:[AppleDeviceUIModel class]]) {
        return;
    }
    
    AppleDeviceUIModel *model = sender;
    if ([segue.destinationViewController isKindOfClass:[AppleDeviceDetailViewController class]]) {
        ((AppleDeviceDetailViewController*)(segue.destinationViewController)).device = model.homekitDevice;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

@end
