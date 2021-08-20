//
//  BEEHomeViewController.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/20.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEEHomeViewController.h"
#import "BEENextViewController.h"
#import <BEENavigationBar/BEENavigationBarHeader.h>

@interface BEEHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation BEEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tipLabel];
    
    self.navigation_bar.statusBarStyle = UIStatusBarStyleDefault;
    [self.navigation_bar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics: UIBarMetricsDefault];
    
    self.navigation_item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarButtonAction)];
    self.navigation_item.title = @"Home";
    self.navigation_bar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blueColor, NSFontAttributeName: [UIFont systemFontOfSize:24]};
    
    self.navigation_bar.backBarButtonItem.willBack = ^{
        NSLog(@"willBack");
    };
    
    self.navigation_bar.backBarButtonItem.didBack = ^{
        NSLog(@"didBack");
    };
    
    self.navigation_bar.automaticallyAdjustsPosition = NO;
    
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.orangeColor, NSFontAttributeName: [UIFont systemFontOfSize:80]};
        self.navigation_bar.prefersLargeTitles = YES;
        self.navigation_item.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
}

- (void)rightBarButtonAction {
    [self.navigationController pushViewController:[BEENextViewController new] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat statusBarMaxY = CGRectGetMinY(self.navigationController.navigationBar.frame);
    CGFloat originY = -scrollView.contentOffset.y + statusBarMaxY;
    CGFloat alpha = 1 - (scrollView.contentOffset.y) / (self.navigation_bar.frame.size.height);
    [self.navigation_bar setTitleAlpha:alpha];
    [self.navigation_bar setTintAlpha:alpha];
    if (@available(iOS 11.0, *)) {
        [self.navigation_bar setLargeTitleAlpha:alpha];
    }
    if (originY <= statusBarMaxY) {
        CGFloat minY = statusBarMaxY - self.navigation_bar.frame.size.height;
        CGRect frame = self.navigation_bar.frame;
        frame.origin.y = originY > minY ? originY : minY;
        self.navigation_bar.frame = frame;
    } else {
        if (@available(iOS 11.0, *)) {
            [self.navigation_bar setLargeTitleAlpha:1.0];
        }
        [self.navigation_bar setTitleAlpha:1.0];
        [self.navigation_bar setTintAlpha:1.0];
        
        CGRect frame = self.navigation_bar.frame;
        frame.origin.y = statusBarMaxY;
        self.navigation_bar.frame = frame;
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        _tipLabel.center = self.view.center;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"上下滑动试试";
    }
    return _tipLabel;
}

@end
