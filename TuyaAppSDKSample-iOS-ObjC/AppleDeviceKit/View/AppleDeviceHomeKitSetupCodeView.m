//
//  AppleDeviceHomeKitSetupCodeView.m
//  TuyaAppSDKSample-iOS-ObjC
//
//  Created by 萧然 on 2021/3/22.
//

#import "AppleDeviceHomeKitSetupCodeView.h"
#import <Masonry/Masonry.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define NavAndStatusHeight 44 + [[UIApplication sharedApplication] statusBarFrame].size.height

@interface AppleDeviceHomeKitSetupCodeView ()

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *codeShowLabel;

@property (nonatomic, strong) UIView *separateLine;

@property (nonatomic, strong) UIButton *expendButton;

@property (nonatomic, assign) BOOL isClosed;

@end

@implementation AppleDeviceHomeKitSetupCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _margin = 40;
        _top = NavAndStatusHeight + 16;
        [self setupUI];
        [self makeConstraints];
    }
    return self;
}

- (void)updateCodeString:(NSString *)codeString {
    // HomeKit setup code
    self.codeShowLabel.text = codeString;
    [self.codeShowLabel sizeToFit];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_margin);
            make.width.mas_equalTo(ScreenWidth - _margin * 2);
            make.top.mas_equalTo(_top);
            make.bottom.mas_equalTo(self.codeShowLabel.mas_bottom).offset(12);
    }];
}

- (void)hide {
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)expend {
    if (self.isClosed) {
        // opening
        self.codeShowLabel.hidden = NO;
        self.separateLine.hidden = NO;
        CGRect rect = self.frame;
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_margin);
                make.width.mas_equalTo(ScreenWidth - _margin * 2);
                make.top.mas_equalTo(_top);
                make.height.mas_equalTo(rect.size.height);
        }];
        self.expendButton.transform = CGAffineTransformIdentity;
    } else {
        // closing
        self.codeShowLabel.hidden = YES;
        self.separateLine.hidden = YES;
        CGRect rect = self.frame;
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_margin);
                make.width.mas_equalTo(52);
                make.top.mas_equalTo(_top);
                make.height.mas_equalTo(rect.size.height);
        }];
        self.expendButton.transform = CGAffineTransformMakeRotation(M_PI);
    }
    self.isClosed = !self.isClosed;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
    // shadow
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 0.03;
    self.contentView.layer.shadowRadius = 10;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)makeConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    [self.expendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(48);
    }];
    [self.codeShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self);
            make.left.mas_equalTo(60);
    }];
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.expendButton.mas_right);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(1);
    }];
}
#pragma mark - Property
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (UILabel *)codeShowLabel {
    if (!_codeShowLabel) {
        UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        codeLabel.font = [UIFont boldSystemFontOfSize:14];
        codeLabel.numberOfLines = 0;
        _codeShowLabel = codeLabel;
        [self.contentView addSubview:_codeShowLabel];
    }
    return _codeShowLabel;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc] initWithFrame:CGRectZero];
        _separateLine.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
        [self.contentView addSubview:_separateLine];
    }
    return _separateLine;
}

- (UIButton *)expendButton {
    if (!_expendButton) {
        _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expendButton setImage:[UIImage imageNamed:@"ty_device_homekit_code_arrow"] forState:0];
        [_expendButton addTarget:self action:@selector(expend) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_expendButton];
        
    }
    return _expendButton;
}

@end
