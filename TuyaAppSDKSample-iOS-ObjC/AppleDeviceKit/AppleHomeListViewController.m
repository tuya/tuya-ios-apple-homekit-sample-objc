//
//  AppleHomeListViewController.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Copyright (c) 2014-2021 Tuya Inc. (https://developer.tuya.com/)

#import "AppleHomeListViewController.h"
#import "AppleDeviceListViewController.h"
#import <TuyaSmartAppleDeviceKit/TuyaSmartHomeKitPermissionUtil.h>

@interface AppleHomeListViewController ()

@property (nonatomic, strong) NSArray<HMHome *> *homes;

@end

@implementation AppleHomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home List";
    [self loadHomeKitData];
    [self observeHomesUpdate];
}
- (void)loadHomeKitData {
    [[AppleDeviceKitManager sharedInstance].permissionUtil checkHomeKitPermissionWithCompletionHandler:^(BOOL granted, HMHomeManager * _Nullable manager) {
        if (!granted) {
            NSLog(@"NO HomeKit Permission！");
            return;
        }
        // HomeKit Authorized
        [[AppleDeviceKitManager sharedInstance].util homeKitDataCompletionHandler:^(HMHomeManager * _Nullable manager) {
            self.homes = [[AppleDeviceKitManager sharedInstance].util homes];
            [self.tableView reloadData];
        }];
    }];
}

- (void)observeHomesUpdate {
    [[AppleDeviceKitManager sharedInstance].util homesUpdatedHandler:^(HMHomeManager * _Nullable manager) {
        self.homes = [[AppleDeviceKitManager sharedInstance].util homes];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"apple-home-cell" forIndexPath:indexPath];
    HMHome *home = self.homes[indexPath.row];
    cell.textLabel.text = home.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HMHome *home = self.homes[indexPath.row];
    [self performSegueWithIdentifier:@"show-apple-device-list" sender:home];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.identifier isEqualToString:@"show-apple-device-list"]) {
        return;
    }
    
    if (![sender isKindOfClass:[HMHome class]]) {
        return;
    }
    
    HMHome *model = sender;
    if ([segue.destinationViewController isKindOfClass:[AppleDeviceListViewController class]]) {
        ((AppleDeviceListViewController*)(segue.destinationViewController)).home = model;
    }
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
